pipeline {
    agent any
    stages {
        stage('Build docker') {
            steps
            {
                dockerImage = docker.build("springboot-deploy:${env.BUILD_NUMBER}")
            }
          }
        stage('Run docker container') {
            steps
            {
                sh 'docker ps -q --filter ancestor=$dockerImage | xargs -r docker stop'
                sh 'docker run -d -p 8080:8080 $dockerImage'
            }
          }
        }
    }