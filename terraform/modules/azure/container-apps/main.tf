resource "azurerm_log_analytics_workspace" "log-analytics-workspace" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name              = var.container-app-properties.log-analytics-workspace-name
  sku               = "PerGB2018"
  retention_in_days = 30
}

resource "azurerm_container_app_environment" "container-app-environment" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.location

  name                       = var.container-app-properties.container-app-environment-name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log-analytics-workspace.id
}

resource "azurerm_container_app" "container-app" {
  resource_group_name = var.resource-group-properties.rg-name

  name                         = var.container-app-properties.container-app-name
  container_app_environment_id = azurerm_container_app_environment.container-app-environment.id
  revision_mode                = "Single"

  template {
    container {
      name   = var.container-app-properties.container-name
      image  = var.container-app-properties.container-image-name
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
  ingress {
    allow_insecure_connections = false
    target_port                = 80

    traffic_weight {
      percentage = 100
    }
  }
}