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
      git branch: 'main', url: 'https://github.com/KolluruSrinivas/Jenkins-Pipeline.git'
     }
  }
          }
          stage('Terraform Init'){
            steps{
              sh 'terraform init'
            }
          }
          stage('Terraform Plan'){
             steps {
                // Generate and save Terraform plan
                sh 'terraform plan -out=tfplan'
            }
          }

          stage('Terraform Apply'){
            steps {
                // Apply Terraform changes
                sh 'terraform apply -auto-approve tfplan'
            }
          }
        } 
    }
