terraform {
  required_version = ">= 1.10.3"

  # For Azure
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.14.0"
    }
  }

  # Only use backend block when Remote Backend Storage is provisioned
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "terraformstate123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    # use_azuread_auth     = true                         # Enables Azure AD authentication
    # table_name           = "terraform-locks"            # Enables state locking
  }
}

provider "azurerm" {
  features {}

  subscription_id = local.subscription-id
}
