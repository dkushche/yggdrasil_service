pipeline {
    agent any

    stage("Prepare Image") {
        docker.withRegistry('http://registry.registry.svc.cluster.local', 'roothazardlab-registry') {
            def yggdrasilGatewayImage = docker.build("yggdrasil_gateway_image:${env.BUILD_ID}")

            yggdrasilGatewayImage.push()
        }
    }
}
