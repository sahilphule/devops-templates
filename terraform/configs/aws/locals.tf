locals {
  aws-region = "ap-south-1"

  # Only use config parameter when using Terraform Workspaces
  config = terraform.workspace == "prod" ? local.prod-config : terraform.workspace == "dev" ? local.dev-config : local.default-config
}