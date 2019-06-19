pipeline {
  agent { node { label 'master'}}

  environment {
    MAJOR_VERSION = "1.0.0"
    VERSION = "${MAJOR_VERSION}-${BUILD_NUMBER}"
  }

  stages {
    stage('git clone and building images and templates'){
      steps {
        checkout scm
        script {
          withCredentials([string(credentialsId: '0da3edbb-7716-449d-973a-6714e6bce8b7', variable: 'API_KEY')]){
            docker.withRegistry('https://forgerockcontainer1.azurecr.io', 'b0cf778a-c523-4655-bf5c-b2a05aa3934e') {
              docker.build('acmecorp/downloader:latest', '--build-arg API_KEY=$API_KEY docker/downloader/').push()
              def dsImage = docker.build('acmecorp/ds:${VERSION}', 'docker/ds/')
              dsImage.push()
              dsImage.push('${MAJOR_VERSION}-latest')
              def idmImage = docker.build('acmecorp/openidm:${VERSION}', 'docker/openidm/')
              idmImage.push()
              idmImage.push('${MAJOR_VERSION}-latest')
              def amImage = docker.build('acmecorp/openam:${VERSION}', 'docker/openam/')
              amImage.push()
              amImage.push('${MAJOR_VERSION}-latest')
              def javaImage = docker.build('acmecorp/java:${VERSION}', 'docker/java/')
              javaImage.push()
              javaImage.push('${MAJOR_VERSION}-latest')
              def amsterImage = docker.build('acmecorp/amster:${VERSION}', 'docker/amster/')
              amsterImage.push()
              amsterImage.push('${MAJOR_VERSION}-latest')
              def utilImage = docker.build('acmecorp/util:${VERSION}', 'docker/util/')
              utilImage.push()
              utilImage.push('${MAJOR_VERSION}-latest')
              def gitImage = docker.build('acmecorp/git:${VERSION}', 'docker/git/')
              gitImage.push()
              gitImage.push('${MAJOR_VERSION}-latest')

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
