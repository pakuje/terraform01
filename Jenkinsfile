
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
            git credentialsId: 'git', url: 'https://github.com/pakuje/terraform01.git'
            }
        }        
         stage('Terraform Init'){
            
            steps {                    
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'sp_terraform',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
                        
                        sh """
                                
                        echo "Initialising Terraform"
                        terraform init -backend-config="access_key=$ARM_ACCESS_KEY" --backend-config="env/backend.tfvars"
                        """
                           }
                    
             }
            }
            
    }
}
