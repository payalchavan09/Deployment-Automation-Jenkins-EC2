pipeline {
    agent any
    tools {
        maven 'Maven 3.9.2'
        jdk 'Java 17.0.4.1'
    }
    stages {
        stage('---clean---') {
            steps {
                sh "mvn clean"
            }
        }
        stage('--test--') {
            steps {
                sh "mvn test"
            }
        }
        stage('--package--') {
            steps {
                sh "mvn package"
            }
        }
    }
}