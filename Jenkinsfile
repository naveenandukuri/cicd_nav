pipeline(){
    agent any
    environment{
        imageName="maven-project"
        registeryCredentials= "NEXUS_CREDENTIALS"
        registry="3.142.150.13:8082/"
    }
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
        stage('docker'){
            steps{
                script{
                    sh 'docker build -t maven-project:latest .'
                }
            }
        }
        stage("upload docker image"){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'NEXUS_CREDENTIALS', url: 'http://3.142.150.13:8082/') {
                        def customImage = docker.build("imageName:${env.BUILD_ID}")

                        customImage.push()
                    }
                }
            }
        }
        stage("nexus"){
            steps{
                script{
                    nexusArtifactUploader artifacts: [[artifactId: '$BUILD_TIMESTAMP', classifier: '', file: 'webapp/target/webapp.war', type: 'war']], credentialsId: 'NEXUS_CREDENTIALS', groupId: 'QA', nexusUrl: '3.142.150.13:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'test', version: '$BUILD_ID'
                }
            }
        }
        
    }
}