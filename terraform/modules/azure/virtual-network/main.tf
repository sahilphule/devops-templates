resource "azurerm_virtual_network" "vnet" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name          = var.virtual-network-properties.vnet-name
  address_space = var.virtual-network-properties.vnet-address-space
}