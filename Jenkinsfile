pipeline(){
    agent any
    stages{
        stage("git"){
            steps{
                script{
                    sh '''echo passed'''
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