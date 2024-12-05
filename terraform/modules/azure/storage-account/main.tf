resource "azurerm_storage_account" "storage-account" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                     = var.storage-account-properties.sa-name
  account_tier             = var.storage-account-properties.sa-tier
  account_replication_type = var.storage-account-properties.sa-replication-type

  network_rules {
    default_action = "Deny"
    # ip_rules = 
    virtual_network_subnet_ids = [var.vnet-public-subnet-id]
  }

}