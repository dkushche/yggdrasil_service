pipeline {
    agent any

    parameters {
        string(name: 'LOADBALANCER_IP', defaultValue: 'None', description: 'Where redirect traffic from yggdrasil?')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Do you want to deploy it in the lab?')
    }

    stages {
        stage("Prepare Image") {
            steps {
                script {
                    docker.withRegistry('https://registry.roothazardlab.com', 'roothazardlab-registry') {
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
            when {
                expression { return params.DEPLOY }
            }

            steps {
                script {
                    sh "kubectl apply -f .roothazardlab/yggdrasil-conf-secret.yaml"
                    sh "kubectl apply -f .roothazardlab/yggdrasil-peers-conf.yaml"
                    sh "kubectl apply -f .roothazardlab/yggdrasil.yaml"
                    sh "kubectl rollout restart deployment/yggdrasil -n projects"
                }
            }
        }
    }
}
