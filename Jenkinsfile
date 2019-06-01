pipeline {
  agent { node { label 'master'}}
  stages {
    stage('git clone and building images and templates'){
      steps {
        checkout scm
        script {
          withCredentials([string(credentialsId: '0da3edbb-7716-449d-973a-6714e6bce8b7', variable: 'API_KEY')]){
            docker.withRegistry('https://forgerockcontainer1.azurecr.io', 'b0cf778a-c523-4655-bf5c-b2a05aa3934e') {
              docker.build('acmecorp/downloader:latest', '--build-arg API_KEY=$API_KEY docker/downloader/').push()
              docker.build('acmecorp/ds:1.0.0-$BUILD_NUMBER', 'docker/ds/').push()
              docker.build('acmecorp/openidm:1.0.0-$BUILD_NUMBER', 'docker/openidm/').push()
              docker.build('acmecorp/openam:1.0.0-$BUILD_NUMBER', 'docker/openam/').push()
              docker.build('acmecorp/java:1.0.0-$BUILD_NUMBER', 'docker/java/').push()
              docker.build('acmecorp/amster:1.0.0-$BUILD_NUMBER', 'docker/amster/').push()
              docker.build('acmecorp/util:1.0.0-$BUILD_NUMBER', 'docker/util/').push()
              docker.build('acmecorp/git:1.0.0-$BUILD_NUMBER', 'docker/git/').push()

              withCredentials([usernamePassword(credentialsId: 'azurecreds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh 'az login -u $USERNAME -p $PASSWORD'
                sh 'cd helm && ./pack_push.sh $BUILD_NUMBER'
              }
            }
          }
        }
      }
    }
  }
}
