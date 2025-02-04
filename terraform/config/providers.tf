terraform {
  required_version = ">= 1.10.3"

  # For AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.85.0"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state-bucket"        # S3 bucket for state storage
    key            = "path/to/my/state.tfstate"         # Path in the S3 bucket
    region         = "ap-south-1"                       # Region where the S3 bucket is located
    dynamodb_table = "my-lock-table"                    # DynamoDB table for state locking
    encrypt        = true                               # Enable encryption of the state file in S3
  }

  # For Azure
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.14.0"
    }
  }
}

provider "aws" {
  region = local.aws-region

  # shared_config_files = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}

provider "azurerm" {
  features {}

  subscription_id = local.subscription-id
}