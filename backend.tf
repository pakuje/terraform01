
terraform {
  backend "azurerm" {
    resource_group_name  = "pkjTest02"
    storage_account_name = "terraformtfstatepkj"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

