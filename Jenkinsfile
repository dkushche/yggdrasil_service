pipeline {
    agent any

    parameters {
        string(name: 'LOADBALANCER_IP', defaultValue: 'None', description: 'Where redirect traffic from yggdrasil?')
    }

    stages {
        stage("Install dependencies") {
            steps {
                script {
                    sh "apt update"
                    sh "apt install -y git-crypt apt-transport-https ca-certificates curl"

                    sh "curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg"
                    sh "echo \"deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main\" | tee /etc/apt/sources.list.d/kubernetes.list"

                    sh "apt update"
                    sh "apt install -y kubectl"
                }
            }
        }

        stage("Prepare Image") {
            steps {
                script {
                    docker.withRegistry('https://registry.roothazardlab.com:443', 'roothazardlab-registry') {
                        docker.build("yggdrasil_gateway_image:latest", "--build-arg LOADBALANCER_IP='${params.LOADBALANCER_IP}' .").push()
                    }
                }
            }
        }

        stage("Unlock roothazardlab secrets") {
            steps {
                script {
                    withCredentials([file(credentialsId: 'roothazardlab-git-crypt-key', variable: 'FILE')]) {
                        sh 'git-crypt unlock $FILE'
                    }
                }
            }
        }

        stage("Deploy in Lab") {
            steps {
                script {
                    sh "kubectl apply -f .roothazardlab/namespace.yaml"
                    sh "kubectl apply -f .roothazardlab/yggdrasil-conf-secret.yaml"
                    sh "kubectl apply -f .roothazardlab/yggdrasil.yaml"
                }
            }
        }
    }
}
