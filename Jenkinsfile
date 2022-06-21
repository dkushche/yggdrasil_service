pipeline {
    agent any

    parameters {
        string(name: 'LOADBALANCER_IP', defaultValue: 'None', description: 'Where redirect traffic from yggdrasil?')
    }

    stages {
        stage("Prepare Image") {
            steps {
                script {
                    docker.withRegistry('https://registry.roothazardlab.com:443', 'roothazardlab-registry') {
                        docker.build("yggdrasil_gateway_image:latest", "--build-arg FORWARD_TO='${params.LOADBALANCER_IP}'").push()
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
