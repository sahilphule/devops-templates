resource "azurerm_resource_group" "rg" {
  location = var.resource-group-properties.rg-location
  name     = var.resource-group-properties.rg-name
}