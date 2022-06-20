pipeline {
    agent any

    stages {
        stage("Prepare Image") {
            steps {
                script {
                    docker.withRegistry('https://registry.roothazardlab.com', 'roothazardlab-registry') {
                        def yggdrasilGatewayImage = docker.build("yggdrasil_gateway_image:${env.BUILD_ID}")

                        yggdrasilGatewayImage.push()
                    }
                }
            }
        }
    }
}
