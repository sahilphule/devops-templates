locals {
  aws-region                   = "ap-south-1"
  aws-default-tags-Environment = "dev"
  aws-default-tags-ManagedBy   = "terraform"

  # Only use config parameter when using Terraform Workspaces
  config = terraform.workspace == "prod" ? local.prod-config : terraform.workspace == "dev" ? local.dev-config : local.default-config
}
