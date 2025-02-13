locals {
  # resource group properties
  resource-group-properties = {}

  # acr properties
  acr-properties = {
    acr-name                          = "acr"
    acr-sku                           = "Basic"
    acr-admin-enabled                 = true
    acr-public-network-access-enabled = true
  }
}
