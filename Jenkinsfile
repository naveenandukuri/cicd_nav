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
            
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'SONAR_CRED') {
                        sh 'mvn sonar:sonar'
                    }
                }
            }
        }
        stage("mvn build"){
            steps{
                script{
                    sh 'mvn clean package'
                }
            }
        }
        stage("nexus"){
            steps{
                script{
                    nexusArtifactUploader artifacts: [[artifactId: '$BUILD_TIMESTAMP', classifier: '', file: 'webapp/target/webapp.war', type: 'war']], credentialsId: 'NEXUS_CREDENTIALS', groupId: 'QA', nexusUrl: '18.218.101.70:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'test', version: '$BUILD_ID'
                }
            }
        }
    }
}