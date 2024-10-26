output "vnet-id" {
  description = "vnet id"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet-name" {
  description = "vnet name"
  value       = azurerm_virtual_network.vnet.name
}