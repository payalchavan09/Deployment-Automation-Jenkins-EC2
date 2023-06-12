node {
  stage("Clone the project") {
    credentialsId: '5350e6a5-ccff-47b6-ad1c-9f3b12dea104'
    git url: 'git@github.com:payalchavan09/helloworld-EC2-CICD.git'
  }

  stage("Compilation") {
    sh "./mvnw clean install -DskipTests"
  }

  stage("Tests and Deployment") {
    stage("Runing unit tests") {
      sh "./mvnw test -Punit"
    }
    stage("Deployment") {
      sh 'nohup ./mvnw spring-boot:run -Dserver.port=8001 &'
    }
  }
}