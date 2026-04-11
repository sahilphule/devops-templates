locals {
  subscription-id = ""

  # Only use config parameter when using Terraform Workspaces
  config = terraform.workspace == "prod" ? local.prod-config : terraform.workspace == "dev" ? local.dev-config : local.default-config
}
