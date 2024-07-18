pipeline {
    agent any
    stages {
        stage('Read HTML File') {
            steps {
                script {
                    def htmlContent = readFile 'index.html'
                    echo "Content of HTML file:"
                    echo htmlContent
                    // Further steps using the HTML content
                }
            }
        }
          stage ('Git Checkout') {
              steps {
                  git branch: 'main', credentialsId:'4d332a54-cd64-43a6-aad1-a97f4447f947', url: 'https://github.com/KolluruSrinivas/Jenkins-Pipeline.git'
                 }
              }
        
          stage('Terraform Init'){
            steps{
             echo "Terraform init"
            }
          }
          stage('Terraform Plan'){
             steps {
                // Generate and save Terraform plan
               echo "Terraform plan"
            }
          }

          stage('Terraform Apply'){
            steps {
                // Apply Terraform changes
               echo "Terraform apply"
            }
          }
            stage('SonarQube Analysis') {
            steps {
                // Run SonarQube Scanner
                withSonarQubeEnv('sonarqube') {
                    sh 'mvn clean verify sonar:sonar'
                    echo "completed sonar qube anay"
                    
                }
            }
        }
    }
    post {
        always {
            script {
                #def qg = waitForQualityGate()
                echo "start"
                #if (qg.status != 'OK') {
                 #   error "Pipeline aborted due to quality gate failure: ${qg.status}"
               # }
            }
        }
    }

} 
 
