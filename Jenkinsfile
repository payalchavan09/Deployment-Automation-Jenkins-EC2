pipeline {
    agent any
    tools {
        maven 'Maven 3.9.2'
        jdk 'Java 11'
    }
    stages {
        stage('Build stage') {
            steps {
                sh "mvn clean",
                sh "mvn test",
                sh "mvn package"
            }

        stage('Build docker') {
                dockerImage = docker.build("springboot-deploy:${env.BUILD_NUMBER}")
          }
        stage('Run docker container') {
                docker ps -q --filter ancestor=$dockerImage | xargs -r docker stop
                docker run -d -p 8080:8080 $dockerImage 
          }
        }
    }
}