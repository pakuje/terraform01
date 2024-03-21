pipeline {
  agent any
  environment {
    AZURE_SUBSCRIPTION_ID='bb4ca9fd-76d6-47a4-89e0-0c5f4c146a0d'
    AZURE_TENANT_ID='d63d0b02-54e5-46ed-b8ef-1d4e001d14ff'
    AZURE_STORAGE_ACCOUNT='terraformtfstatepkj'
  }
  stages {
    stage('Build') {
      steps {
        sh 'rm -rf *'
        sh 'mkdir text'
        sh 'echo Hello Azure Storage from Jenkins > ./text/hello.txt'
        sh 'date > ./text/date.txt'
      }

      post {
        success {
          withCredentials([usernamePassword(credentialsId: 'sp-terraform', 
                          passwordVariable: 'AZURE_CLIENT_SECRET', 
                          usernameVariable: 'AZURE_CLIENT_ID')]) {
            sh '''
              echo $container_name
              # Login to Azure with ServicePrincipal
              az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
              # Set default subscription
              az account set --subscription $AZURE_SUBSCRIPTION_ID
              # Execute upload to Azure
              az storage container create --account-name $AZURE_STORAGE_ACCOUNT --name $JOB_NAME --auth-mode login
              az storage blob upload-batch --destination ${JOB_NAME} --source ./text --account-name $AZURE_STORAGE_ACCOUNT
              # Logout from Azure
              az logout
            '''
          }
        }
      }
    }
  }
}