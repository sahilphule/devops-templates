locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # container app setup properties
  container-app-setup-properties = {
    ca-log-analytics-workspace-name              = "ca-log-analytics-workspace"
    ca-log-analytics-workspace-sku               = "PerGB2018"
    ca-log-analytics-workspace-retention-in-days = 30
    ca-environment-name                          = "ca-environment"

    ca-environment-workload-profile-name = "standard-workload"
    ca-environment-workload-profile-type = "Consumption" # Consumption, D4, D8, D16, D32, E4, E8, E16, E32
  }
}
