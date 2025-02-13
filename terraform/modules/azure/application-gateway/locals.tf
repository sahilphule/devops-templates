locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # application gateway properties
  application-gateway-properties = {
    app-gw-public-ip-name = "app-gw-public-ip"

    app-gw-name         = "app-gw"
    app-gw-sku-name     = ""
    app-gw-sku-tier     = ""
    app-gw-sku-capacity = ""

    app-gw-ip-configuration-name          = ""
    app-gw-frontend-port-name             = ""
    app-gw-frontend-ip-configuration-name = ""
    app-gw-backend-address-pool-name      = ""
    app-gw-backend-http-settings-name     = ""
    app-gw-http-listner-name              = ""
    app-gw-request-routing-rule-name      = ""
  }
}
