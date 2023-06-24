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
                    docker.withRegistry( 'http://'+registry, registryCredentials ) {
                    def customImage = docker.build("imageName:${env.BUILD_ID}")
                        customImage.push()

                        customImage.push('latest')
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