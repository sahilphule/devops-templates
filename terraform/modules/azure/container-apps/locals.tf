locals {
  # resource group properties
  resource-group-properties = {}

  # acr-login-server   = module.acr.acr-login-server
  # acr-admin-username = module.acr.acr-admin-username
  # acr-admin-password = module.acr.acr-admin-password

  # container app properties
  container-app-properties = {
    ca-name                  = "container-apps"
    ca-revision-mode         = "Single"
    ca-workload-profile-name = "standard-workload"

    ca-template-container-name = "nginx-container"
    # ca-template-container-image  = "${local.acr-login-server}/nginx:latest"
    ca-template-container-cpu    = 0.25
    ca-template-container-memory = "0.5Gi"

    ca-template-min-replicas = 1
    ca-template-max-replicas = 1

    ca-ingress-allow-insecure-connections = false
    ca-ingress-external-enabled           = true
    ca-ingress-target-port                = 80
    ca-ingress-transport                  = "auto"
  }
}
