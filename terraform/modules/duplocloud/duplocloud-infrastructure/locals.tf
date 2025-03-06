locals {
  # duplocloud infrastructure properties
  duplocloud-infrastructure-properties = {
    infra_name        = "prod"
    cloud             = 0 # AWS Cloud
    region            = "us-west-2"
    enable-k8-cluster = false
    address-prefix    = "10.11.0.0/16"
  }
}
