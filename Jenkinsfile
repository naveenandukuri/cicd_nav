pipeline(){
    agent any
    stages{
        stage("git"){
            steps{
                script{
                    sh 'echo passed'
                }
            }
        }
        stage("sonar quality"){
            agent {
                docker {
                    image 'maven:3.6.3-openjdk-11'
                    args '-u root'
                }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'SONAR_CRED') {
                        sh 'mvn sonar:sonar'
                    }
                    waitForQualityGate abortPipeline: false, credentialsId: 'SONAR_CRED'
                }
            }
        }
    }
}