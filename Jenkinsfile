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
        stage("maven"){
            steps{
                script{
                    sh 'mvn clean package'
                }
            }
        }
        stage("sonar quality"){
            agent {
                docker {
                    image 'maven'
                    args '-u root'
                }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'SONAR_CRED') {
                        sh 'mvn sonar:sonar'
                    }
                }
            }
        }
    }
}