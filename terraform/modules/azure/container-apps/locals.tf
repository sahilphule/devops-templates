locals {

  # resource group properties
  resource-group-properties = {}

  # acr-admin-username    = module.acr.acr-admin-username
  # acr-admin-password    = module.acr.acr-admin-password

  # container app properties
  container-app-properties = {
    ca-name              = "container-apps"
    ca-registry-server   = ""
    container-name       = ""
    container-image-name = ""
  }
}