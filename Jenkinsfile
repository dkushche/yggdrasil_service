pipeline {
    agent any

    stages {
        stage("Prepare Image") {
            steps {
                script {
                    docker.withRegistry('http://registry.registry.svc.cluster.local', 'roothazardlab-registry') {
                        def yggdrasilGatewayImage = docker.build("yggdrasil_gateway_image:${env.BUILD_ID}")

                        yggdrasilGatewayImage.push()
                    }
                }
            }
        }
    }
}
