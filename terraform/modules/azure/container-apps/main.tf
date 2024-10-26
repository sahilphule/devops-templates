resource "azurerm_subnet" "container-app-vnet-public-subnet" {
  resource_group_name = var.resource-group-properties.rg-name

  name                 = var.container-app-properties.container-app-vnet-subnet-name
  virtual_network_name = var.vnet-name
  address_prefixes     = var.container-app-properties.container-app-vnet-subnet-address-prefixes
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_log_analytics_workspace" "container-app-log-analytics-workspace" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name              = var.container-app-properties.container-app-log-analytics-workspace-name
  sku               = "PerGB2018"
  retention_in_days = 30
}

resource "azurerm_container_app_environment" "container-app-environment" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                       = var.container-app-properties.container-app-environment-name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.container-app-log-analytics-workspace.id
  infrastructure_subnet_id   = azurerm_subnet.container-app-vnet-public-subnet.id
}

resource "azurerm_container_app" "container-app" {
  resource_group_name = var.resource-group-properties.rg-name

  name                         = var.container-app-properties.container-app-name
  container_app_environment_id = azurerm_container_app_environment.container-app-environment.id
  revision_mode                = "Single"

  # registry {
  #   server = "docker.io"
  #   username = ""
  #   password_secret_name = "docker-io-pass"
  # }

  # secret {
  #   name = "docker-io-pass"
  #   value = ""
  # }

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
    external_enabled           = true
    target_port                = 80
    # exposed_port               = 7272
    transport                  = "auto"

    traffic_weight {
      percentage = 100
    }
  }
}