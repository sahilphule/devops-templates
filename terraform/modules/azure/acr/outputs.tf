output "acr-id" {
  description = "acr id"
  value       = azurerm_container_registry.acr.id
}

output "acr-name" {
  description = "acr name"
  value       = azurerm_container_registry.acr.name
}

output "acr-login-server" {
  description = "acr login server"
  value       = azurerm_container_registry.acr.login_server
}