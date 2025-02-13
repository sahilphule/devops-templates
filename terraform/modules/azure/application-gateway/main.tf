resource "azurerm_public_ip" "public-ip" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name              = var.application-gateway-properties.app-gw-public-ip-name
  allocation_method = "Static"
}

resource "azurerm_application_gateway" "application-gateway" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name = var.application-gateway-properties.app-gw-name

  sku {
    name     = var.application-gateway-properties.app-gw-sku-name
    tier     = var.application-gateway-properties.app-gw-sku-tier
    capacity = var.application-gateway-properties.app-gw-sku-capacity
  }

  gateway_ip_configuration {
    name      = var.application-gateway-properties.app-gw-ip-configuration-name
    subnet_id = var.vnet-public-subnet-id
  }

  frontend_port {
    name = var.application-gateway-properties.app-gw-frontend-port-name
    port = 80
  }

  frontend_ip_configuration {
    name                 = var.application-gateway-properties.app-gw-frontend-ip-configuration-name
    public_ip_address_id = azurerm_public_ip.public-ip.id
  }

  backend_address_pool {
    name = var.application-gateway-properties.app-gw-backend-address-pool-name
  }

  backend_http_settings {
    name                  = var.application-gateway-properties.app-gw-backend-http-settings-name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = var.application-gateway-properties.app-gw-http-listener-name
    frontend_ip_configuration_name = var.application-gateway-properties.app-gw-frontend-ip-configuration-name
    frontend_port_name             = var.application-gateway-properties.app-gw-frontend-port-name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = var.application-gateway-properties.app-gw-request-routing-rule-name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = var.application-gateway-properties.app-gw-http-listener-name
    backend_address_pool_name  = var.application-gateway-properties.app-gw-backend-address-pool-name
    backend_http_settings_name = var.application-gateway-properties.app-gw-backend-http-settings-name
  }
}
