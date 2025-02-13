resource "azurerm_resource_group" "resource-group" {
  location = var.resource-group-properties.rg-location
  name     = var.resource-group-properties.rg-name
}
