pipeline {
    agent any

    stages {
        stage("Prepare Image") {
            steps {
                script {
                    docker.withRegistry('https://registry.roothazardlab.com:443', 'roothazardlab-registry') {
                        def yggdrasilGatewayImage = docker.build("yggdrasil_gateway_image:latest")

                        yggdrasilGatewayImage.push()
                    }
                }
            }
        }
    }
}
