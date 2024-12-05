resource "azurerm_storage_account" "storage-account" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                          = var.storage-properties.sa-name
  account_tier                  = var.storage-properties.sa-tier
  account_kind                  = var.storage-properties.sa-kind
  account_replication_type      = var.storage-properties.sa-replication-type
  access_tier                   = var.storage-properties.sa-access-tier
  https_traffic_only_enabled    = var.storage-properties.sa-https-traffic-only-enabled
  public_network_access_enabled = var.storage-properties.sa-public-network-access-enabled

  network_rules {
    default_action = var.storage-properties.sa-network-rules-default-action
    # ip_rules = [""]
    virtual_network_subnet_ids = [var.vnet-public-subnet-id]
  }
}

resource "azurerm_storage_container" "storage-container" {
  name                  = var.storage-properties.sc-name
  storage_account_id    = azurerm_storage_account.storage-account.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storage-blob-object" {
  name                   = var.storage-properties.sb-object-name
  storage_account_name   = azurerm_storage_account.storage-account.name
  storage_container_name = azurerm_storage_container.storage-container.name
  type                   = var.storage-properties.sb-object-type
  source                 = var.storage-properties.sb-object-source-path
}