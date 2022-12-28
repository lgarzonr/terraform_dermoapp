# terraform_dermoapp yey

pipeline {
    agent any
    
    tools {
        terraform 'terraform'
    }
    
    stages{
        stage('init pipe'){
             when{
               not{
                    anyOf{
                    branch 'main';
                    changeRequest target: 'main'
                    }
                 }
            }
            steps{
                script{
                  skipSteps = true
                }
            }
        }
        
        stage('checkout'){
           when{
               expression{
                   !skipSteps
               }
           }
            steps{
checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/lgarzonr/terraform_dermoapp']]])            }
        }
        
        stage('Terraform Init'){
             when{
               expression{
                   !skipSteps
               }
           }
            steps{
                sh 'terraform init'
            }
        }
        
        stage('Terraform format'){
             when{
               expression{
                   !skipSteps
               }
           }
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: "8728be7c-ba70-4410-a825-c53289cad69b",
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                        sh 'terraform fmt -list=true -write=false -diff=false -check=true'
                    }
            }
        }
        
        stage('Terraform Validate'){
             when{
               expression{
                   !skipSteps
               }
           }
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: "8728be7c-ba70-4410-a825-c53289cad69b",
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                        sh 'terraform validate'
                    }
            }
        }
        
        stage('Terraform Plan'){
             when{
               expression{
                   !skipSteps
               }
           }
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: "8728be7c-ba70-4410-a825-c53289cad69b",
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                        sh 'terraform plan -out terraform.tfplan'
                    }
            }
        }
        
          stage('Terraform Apply'){
               when{
               expression{
                   !skipSteps
               }
           }
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: "8728be7c-ba70-4410-a825-c53289cad69b",
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                        sh 'terraform apply terraform.tfplan'
                    }
            }
        }
    }
}
