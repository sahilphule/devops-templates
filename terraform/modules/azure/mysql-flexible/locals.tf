locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-id   = module.virtual-network.vnet-id
  # vnet-name = module.virtual-network.vnet-name

  # mysql flexible properties
  mysql-flexible-properties = {
    vnet-mysql-flexible-subnet-name = "vnet-mysql-flexible-subnet"
    vnet-mysql-flexible-subnet-address-prefixes = [
      "10.1.101.0/24"
    ]

    mysql-flexible-server-name            = "mysql-flexible-server"
    mysql-flexible-administrator-login    = ""
    mysql-flexible-administrator-password = ""
    mysql-flexible-version                = "8.0.21"
    mysql-flexible-sku-name               = "B_Standard_B1ms"
    mysql-flexible-backup-retention-days  = 7
    mysql-flexible-storage-iops           = 360
    mysql-flexible-storage-size-gb        = 20
  }
}
