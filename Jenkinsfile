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
    }
}
