
pipeline {
    agent any
    tools {
         //terraform 'terraform'
         "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }
    environment {
        TF_HOME = tool('terraform')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        AZURE_SUBSCRIPTION_ID='bb4ca9fd-76d6-47a4-89e0-0c5f4c146a0d'
        AZURE_TENANT_ID='d63d0b02-54e5-46ed-b8ef-1d4e001d14ff'
    }
    
    stages{
        stage('Git Checkout') {
           steps{
            //git credentialsId: 'pakuje', url: 'https://github.com/pakuje/terraform.git'
            git credentialsId: 'test12', url: 'https://github.com/pakuje/terraform01.git'
            }
        }
        
         stage('Terraform Init'){            
            steps {
                terraform init                    
                   
            }
                    
        }
    }
            
}

