output "vnet-public-subnet-id" {
  description = "vnet public subnet id"
  value       = azurerm_subnet.vnet-public-subnet.id
}

output "vnet-db-subnet-id" {
  description = "vnet db subnet id"
  value       = azurerm_subnet.vnet-db-subnet.id
}