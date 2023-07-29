pipeline {
    agent any
    stages {
        stage('Build docker') {
            steps
            {
                script{
                    sh "docker build -t myfile ."
                }
            }
          }
        stage('Run docker container') {
            steps
            {
                script{
                    sh "docker run -d -p 8080:8080 myfile"
                }
            }
          }
        }
    }