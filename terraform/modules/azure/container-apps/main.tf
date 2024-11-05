# resource "azurerm_user_assigned_identity" "user-assigned-identity" {
#   resource_group_name = var.resource-group-properties.rg-name
#   location = var.resource-group-properties.rg-location

#   name = var.container-app-properties.ca-user-assigned-identity-name
# }

# resource "azurerm_role_assignment" "ca-acr-pull" {
#   scope = var.acr-id
#   role_definition_name = "AcrPull"
#   principal_id = azurerm_user_assigned_identity.user-assigned-identity.principal_id
# }

data "azurerm_container_registry_scope_map" "container-app-acr-scope-map-pull-repo" {
  resource_group_name = var.resource-group-properties.rg-name

  name                    = var.container-app-properties.ca-acr-scope-map-pull-repo-name
  container_registry_name = var.acr-name
}

resource "azurerm_container_registry_token" "container-app-acr-pull-token" {
  resource_group_name = var.resource-group-properties.rg-name

  name                    = var.container-app-properties.ca-acr-pull-token-name
  container_registry_name = var.acr-name
  scope_map_id            = data.azurerm_container_registry_scope_map.container-app-acr-scope-map-pull-repo.id
}

resource "azurerm_container_registry_token_password" "container-app-acr-pull-token-password" {
  container_registry_token_id = azurerm_container_registry_token.container-app-acr-pull-token.id

  password1 {
    expiry = timeadd(timestamp(), "24h")
  }

  lifecycle {
    ignore_changes = [password1]
  }
}

resource "azurerm_log_analytics_workspace" "container-app-log-analytics-workspace" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name              = var.container-app-properties.ca-log-analytics-workspace-name
  sku               = "PerGB2018"
  retention_in_days = 30
}

resource "azurerm_container_app_environment" "container-app-environment" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                       = var.container-app-properties.ca-environment-name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.container-app-log-analytics-workspace.id
  infrastructure_subnet_id   = var.vnet-public-subnet-id
}

resource "azurerm_container_app" "container-app" {
  resource_group_name = var.resource-group-properties.rg-name

  name                         = var.container-app-properties.ca-name
  container_app_environment_id = azurerm_container_app_environment.container-app-environment.id
  revision_mode                = "Single"

  # identity {
  #   type         = "UserAssigned"
  #   identity_ids = [azurerm_user_assigned_identity.user-assigned-identity.id]
  # }

  registry {
    server = var.container-app-properties.ca-registry-server
    # identity = azurerm_user_assigned_identity.user-assigned-identity.id
    username             = azurerm_container_registry_token.container-app-acr-pull-token.name
    password_secret_name = "acr-pull-token-password"
  }

  secret {
    name  = "acr-pull-token-password"
    value = azurerm_container_registry_token_password.container-app-acr-pull-token-password.password1[0].value
  }

  template {
    container {
      name   = var.container-app-properties.container-name
      image  = var.container-app-properties.container-image-name
      cpu    = 0.25
      memory = "0.5Gi"
    }
    min_replicas = 1
    max_replicas = 1
  }

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    # exposed_port               = 80
    target_port = 7272
    transport   = "http"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}