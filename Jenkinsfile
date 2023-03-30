pipeline{
    agent any

    environment {
        DOCKERHUB_USERNAME = "holiodin"
        APP_NAME = "jenkins-gitops-argocd"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/${APP_NAME}"
        REGISTRY_CRED = "dockerhub"
    }

    stages{
        stage('cleanup-workspace'){
            steps{
                cleanWs()
            }
        }
        stage('clone-repo'){
            steps{
                git credentialsId: 'github',
                url:'https://github.com/horiodin/jenkins-gitops-argocd.git',
                branch: 'main'
            }
        }
        stage('build-image'){
            steps{
                script{
                    sh 'sudo docker ps -a'
                    // buildimage
                    sh "sudo docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('docker-push'){
            steps{
                // push image to dockerhub
                script{
                    withCredentials([string(credentialsId: 'dockerhub', variable: 'docker')]) {
                        sh """
                        sudo docker login -u ${DOCKERHUB_USERNAME} -p ${docker}
                        sudo docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${IMAGE_TAG}
                        sudo docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        sudo docker push ${IMAGE_NAME}:latest
                        """}
                    }
                }
            }
            stage('deleting-imge'){
                steps{
                    script{
                        sh "sudo docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "sudo docker rmi ${IMAGE_NAME}:latest"
                    }
                }
            }

            stage('trigger-cd-pipeline'){
                steps{
                    script{
                        sh """
                        curl -v -k -u holiodin:<jenkins-credential> -X POST -H 'cache-control: no-cache' -H 'context-type: application/x-www-form-urlencoded' -d "IMAGE_TAG=${IMAGE_TAG}" http://localhost:8080/job/gitops-argocd-cd/buildWithParameters?token=gitops-config
                        """
                    }
                }
            }
        }
}
