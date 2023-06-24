pipeline(){
    agent any
    environment{
        imageName="maven-project"
        registeryCredentials= "NEXUS_CREDENTIALS"
        registry="3.142.150.13:8082/"
        dockerImage= ''
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
                    dockerImage = docker.build imageName
                }
            }
        }
        stage("upload docker image"){
            steps{
                 script {
                    
                    sh 'docker login -u admin -p admin http://3.142.150.13:8082/'
                    sh 'docker push http://3.142.150.13:8082/"imageName:${env.BUILD_ID}"'
                    sh 'docker rmi $(docker images --filter=reference="http://3.142.150.13:8082/ImageName*" -q)'
                    sh 'docker logout http://3.142.150.13:8082/'
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