resource "azurerm_container_registry" "acr" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                          = var.acr-properties.acr-name
  sku                           = var.acr-properties.acr-sku
  admin_enabled                 = var.acr-properties.acr-admin-enabled
  public_network_access_enabled = var.acr-properties.acr-public-network-access-enabled
}
