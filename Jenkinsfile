pipeline {
    agent any
    stages {
        stage('Build docker') {
                dockerImage = docker.build("springboot-deploy:${env.BUILD_NUMBER}")
          }
        stage('Run docker container') {
                docker ps -q --filter ancestor=$dockerImage | xargs -r docker stop
                docker run -d -p 8080:8080 $dockerImage 
          }
        }
    }