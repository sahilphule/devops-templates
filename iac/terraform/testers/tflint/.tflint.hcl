config {
    call_module_type = "all"              # local, all, none
    force = false
    disabled_by_default = false
    varfile = ["example1.tfvars", "example2.tfvars"]
}

plugin "aws" {
  enabled = true
  version = "0.24.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  region  = "ap-south-1"
}

plugin "azurerm" {
  enabled = true
  version = "0.24.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

rule "terraform_required_version" {
  enabled = false
}
