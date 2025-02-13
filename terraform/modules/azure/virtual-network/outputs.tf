output "vnet-id" {
  description = "virtual network id"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet-name" {
  description = "virtual network name"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet-public-subnet-id" {
  description = "virtual network public subnet id"
  value       = azurerm_subnet.vnet-public-subnet.id
}
