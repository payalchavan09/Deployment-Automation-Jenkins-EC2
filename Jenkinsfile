pipeline {
    agent any
    stages {
        stage('Build docker') {
            steps
            {
                sh 'docker build -t myfile .'
            }
          }
        stage('Run docker container') {
            steps
            {
                sh 'docker run -d -p 8080:8080 myfile'
            }
          }
        }
    }