resource "azurerm_subnet" "vnet-mysql-flexible-subnet" {
  resource_group_name = var.resource-group-properties.rg-name

  name                 = var.mysql-flexible-properties.vnet-mysql-flexible-subnet-name
  virtual_network_name = var.vnet-name
  address_prefixes     = var.mysql-flexible-properties.vnet-mysql-flexible-subnet-address-prefixes

  service_endpoints = [
    "Microsoft.Storage"
  ]

  delegation {
    name = "mysql-flexible-server"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_mysql_flexible_server" "mysql-flexible-server" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                   = var.mysql-flexible-properties.mysql-flexible-server-name
  administrator_login    = var.mysql-flexible-properties.mysql-flexible-administrator-login
  administrator_password = var.mysql-flexible-properties.mysql-flexible-administrator-password
  version                = var.mysql-flexible-properties.mysql-flexible-version
  sku_name               = var.mysql-flexible-properties.mysql-flexible-sku-name
  backup_retention_days  = var.mysql-flexible-properties.mysql-flexible-backup-retention-days
  delegated_subnet_id    = azurerm_subnet.vnet-mysql-flexible-subnet.id
  # private_dns_zone_id    = azurerm_private_dns_zone.vnet-mysql-flexible-dns-zone.id
  zone = 1

  storage {
    iops    = var.mysql-flexible-properties.mysql-flexible-storage-iops
    size_gb = var.mysql-flexible-properties.mysql-flexible-storage-size-gb
  }

  depends_on = [
    azurerm_subnet.vnet-mysql-flexible-subnet,
  ]
}

# resource "azurerm_mysql_flexible_database" "mysql-flexible-database" {
#   resource_group_name = var.resource-group-properties.rg-name

#   name        = ""
#   server_name = azurerm_mysql_flexible_server.mysql-flexible-server.name
#   charset     = "utf8"
#   collation   = "utf8_unicode_ci"

#   # timeouts {
#   #   create = "60m" 
#   # }
# }
