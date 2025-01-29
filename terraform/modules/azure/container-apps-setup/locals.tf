locals {

  # resource group properties
  resource-group-properties = {}

  # vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # container app setup properties
  container-app-setup-properties = {
    ca-log-analytics-workspace-name              = "sp-ca-log-analytics-workspace"
    ca-log-analytics-workspace-sku               = "PerGB2018"
    ca-log-analytics-workspace-retention-in-days = 30
    ca-environment-name                          = "sp-prod-ca-environment"
  }
}