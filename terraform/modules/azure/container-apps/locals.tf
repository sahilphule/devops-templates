locals {
  # resource group properties
  resource-group-properties = {}

  vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id
  acr-admin-username    = module.acr.acr-admin-username
  acr-admin-password    = module.acr.acr-admin-password

  # container app properties
  container-app-properties = {
    ca-acr-scope-map-pull-repo-name = "_repositories_pull"
    ca-acr-pull-token-name          = "container-apps-acr-pull-token"

    ca-user-assigned-identity-name = "container-apps-user-assigned-identity"

    ca-log-analytics-workspace-name = "container-apps-log-analytics-workspace"
    ca-environment-name             = "container-apps-environment"

    ca-name = "container-apps"
    # ca-registry-server  = "${local.dockerhub-server}"
    ca-registry-server = ""
    container-name     = ""
    # container-image-name = "${local.dockerhub-repository-url}"
    container-image-name = ""
  }
}