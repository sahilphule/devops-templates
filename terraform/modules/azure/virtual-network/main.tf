resource "azurerm_virtual_network" "vnet" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name          = var.virtual-network-properties.vnet-name
  address_space = var.virtual-network-properties.vnet-address-space
}

resource "azurerm_subnet" "vnet-public-subnet" {
  resource_group_name = var.resource-group-properties.rg-name

  name                 = var.virtual-network-properties.vnet-public-subnet-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.virtual-network-properties.vnet-public-subnet-address-prefixes

  service_endpoints = [
    "Microsoft.Storage"
  ]

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
