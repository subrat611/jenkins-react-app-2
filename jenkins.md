pipeline {
agent any

    stages {
        stage("Deploy Latest Image") {
            steps {
                script {
                    def imageName = "subrat611/react-admin:latest"
                    def containerName = "react-admin"

                    echo "--- Pulling the latest image from registry ---"
                    sh "docker pull ${imageName}"

                    echo "--- Stop & Remove existing running container if any ---"
                    sh "docker stop ${containerName} || true"
                    sh "docker rm ${containerName} || true"

                    echo "--- Starting a new container ---"
                    sh "docker run -d --name ${containerName}  -p 3000:80 ${imageName}"
                }
            }
        }
    }

}
