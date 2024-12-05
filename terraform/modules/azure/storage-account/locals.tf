locals {
  # resource group properties
  resource-group-properties = {}

  vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # storage account properties
  storage-account-properties = {
    sa-name             = "storage-account"
    sa-tier             = "Standard"
    sa-replication-type = "LRS"
  }
}