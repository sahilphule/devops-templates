resource "azurerm_log_analytics_workspace" "container-app-log-analytics-workspace" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name              = var.container-app-setup-properties.ca-log-analytics-workspace-name
  sku               = var.container-app-setup-properties.ca-log-analytics-workspace-sku
  retention_in_days = var.container-app-setup-properties.ca-log-analytics-workspace-retention-in-days
}

resource "azurerm_container_app_environment" "container-app-environment" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                       = var.container-app-setup-properties.ca-environment-name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.container-app-log-analytics-workspace.id
  infrastructure_subnet_id   = var.vnet-public-subnet-id

  workload_profile {
    name                  = var.container-app-setup-properties.ca-environment-workload-profile-name
    workload_profile_type = var.container-app-setup-properties.ca-environment-workload-profile-type
  }
}
