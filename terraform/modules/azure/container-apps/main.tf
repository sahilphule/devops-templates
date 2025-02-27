resource "azurerm_container_app" "container-app" {
  resource_group_name = var.resource-group-properties.rg-name

  name                         = var.container-app-properties.ca-name
  container_app_environment_id = var.container-app-environment-id
  revision_mode                = var.container-app-properties.ca-revision-mode
  workload_profile_name        = var.container-app-properties.ca-workload-profile-name

  registry {
    server               = var.acr-login-server
    username             = var.acr-admin-username
    password_secret_name = "acr-admin-password"
  }

  secret {
    name  = "acr-admin-password"
    value = var.acr-admin-password
  }

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
