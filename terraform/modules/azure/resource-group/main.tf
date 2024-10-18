resource "azurerm_resource_group" "resource-group" {
  location = var.resource-group-properties.resource-group-location
  name = var.resource-group-properties.resource-group-name
}