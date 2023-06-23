pipeline(){
    agent any
    stages{
        stage("git"){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/fet1']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/naveenandukuri/cicd_nav.git']])
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