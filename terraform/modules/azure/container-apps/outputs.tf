output "container-app-url" {
  description = "container app url"
  value       = azurerm_container_app.container-app.latest_revision_fqdn
}