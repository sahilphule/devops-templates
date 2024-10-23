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
  service_endpoints    = ["Microsoft.Sql"]
}

# resource "azurerm_network_security_group" "vnet-public-subnet-sg" {
#   resource_group_name = var.resource-group-properties.name

#   name = "vnet-public-subnet-sg"
#   location = var.resource-group-properties.location

#   tags = {
#     Name= var.virtual-network-properties.vnet-public-subnet-sg-name
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "vnet-public-subnet-sg-assoc" {
#   subnet_id = azurerm_subnet.vnet-public-subnet.id
#   network_security_group_id = azurerm_network_security_group.vnet-public-subnet-sg.id
# }

# resource "azurerm_network_security_rule" "vnet-public-subnet-sg-inbound-rule" {
#   for_each = local.virtual-network-properties.vnet-public-subnet-sg-inbound-ports
#   resource_group_name = var.resource-group-properties.name

#   name = "Rule-Port-${each.value}"
#   priority = each.key
#   direction = "Inbound"
#   access = "Allow"
#   protocol = "Tcp"
#   source_port_range = "*"
#   destination_port_range = "*"
#   network_security_group_name = azurerm_network_security_group.vnet-public-subnet-sg.name
# }

resource "azurerm_subnet" "vnet-db-subnet" {
  resource_group_name = var.resource-group-properties.rg-name

  name                 = var.virtual-network-properties.vnet-db-subnet-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.virtual-network-properties.vnet-db-subnet-address-prefixes
}