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