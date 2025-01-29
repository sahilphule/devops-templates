# resource "azurerm_user_assigned_identity" "user-assigned-identity" {
#   resource_group_name = var.resource-group-properties.rg-name
#   location = var.resource-group-properties.rg-location

#   name = var.container-app-properties.ca-user-assigned-identity-name
# }

# resource "azurerm_role_assignment" "container-app-acr-pull" {
#   scope = var.acr-id
#   role_definition_name = "AcrPull"
#   principal_id = azurerm_user_assigned_identity.user-assigned-identity.principal_id
# }

# data "azurerm_container_registry_scope_map" "container-app-acr-scope-map-pull-repo" {
#   resource_group_name = var.resource-group-properties.rg-name

#   name                    = var.container-app-properties.ca-acr-scope-map-pull-repo-name
#   container_registry_name = var.acr-name
# }

# resource "azurerm_container_registry_token" "container-app-acr-pull-token" {
#   resource_group_name = var.resource-group-properties.rg-name

#   name                    = var.container-app-properties.ca-acr-pull-token-name
#   container_registry_name = var.acr-name
#   scope_map_id            = data.azurerm_container_registry_scope_map.container-app-acr-scope-map-pull-repo.id
# }

# resource "azurerm_container_registry_token_password" "container-app-acr-pull-token-password" {
#   container_registry_token_id = azurerm_container_registry_token.container-app-acr-pull-token.id

#   password1 {
#     expiry = timeadd(timestamp(), "24h")
#   }

#   lifecycle {
#     ignore_changes = [password1]
#   }
# }

resource "azurerm_container_app" "container-app" {
  resource_group_name = var.resource-group-properties.rg-name

  name                         = var.container-app-properties.ca-name
  container_app_environment_id = var.container-app-environment-id
  revision_mode                = var.container-app-properties.ca-revision-mode

  # identity {
  #   type         = "UserAssigned"
  #   identity_ids = [azurerm_user_assigned_identity.user-assigned-identity.id]
  # }

  registry {
    server               = var.container-app-properties.ca-registry-server
    username             = var.acr-admin-username
    password_secret_name = "acr-admin-password"

    # identity = azurerm_user_assigned_identity.user-assigned-identity.id
    # username             = azurerm_container_registry_token.container-app-acr-pull-token.name
    # password_secret_name = "acr-pull-token-password"
  }

  secret {
    name  = "acr-admin-password"
    value = var.acr-admin-password
  }

  # secret {
  #   name  = "acr-pull-token-password"
  #   value = azurerm_container_registry_token_password.container-app-acr-pull-token-password.password1[0].value
  # }

  template {
    container {
      name   = var.container-app-properties.ca-template-container-name
      image  = var.container-app-properties.ca-template-container-image
      cpu    = var.container-app-properties.ca-template-container-cpu
      memory = var.container-app-properties.ca-template-container-memory
    }
    min_replicas = var.container-app-properties.ca-template-min-replicas
    max_replicas = var.container-app-properties.ca-template-max-replicas
  }

  ingress {
    allow_insecure_connections = var.container-app-properties.ca-ingress-allow-insecure-connections
    external_enabled           = var.container-app-properties.ca-ingress-external-enabled
    # exposed_port               = 80
    target_port = var.container-app-properties.ca-ingress-target-port
    transport   = var.container-app-properties.ca-ingress-transport

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}