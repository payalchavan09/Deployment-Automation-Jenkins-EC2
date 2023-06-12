node {
  stage("Clone the project") {
    credentialsId: 'e6be9c3e-11af-44a4-a992-fb8eeb7fd585'
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