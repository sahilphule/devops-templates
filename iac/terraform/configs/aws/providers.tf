terraform {
  required_version = ">= 1.10.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.87.0"
    }
  }

  # Only use backend block when Remote Backend Storage is provisioned
  backend "s3" {
    bucket         = "my-terraform-state-bucket" # S3 bucket for state storage
    key            = "path/to/my/state.tfstate"  # Path in the S3 bucket
    region         = "ap-south-1"                # Region where the S3 bucket is located
    dynamodb_table = "my-lock-table"             # DynamoDB table for state locking
    encrypt        = true                        # Enable encryption of the state file in S3
  }
}

provider "aws" {
  region = local.aws-region

  shared_credentials_files = ["~/.aws/credentials"]
  # shared_config_files = ["~/.aws/config"]
  # profile = ""

  default_tags {
    tags = {
      Environment = local.aws-default-tags-Environment
      ManagedBy   = local.aws-default-tags-ManagedBy
    }
  }
}
