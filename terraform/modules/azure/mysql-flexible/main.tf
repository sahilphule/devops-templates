resource "azurerm_subnet" "mysql-vnet-private-subnet" {
  resource_group_name = var.resource-group-properties.rg-name

  name                 = var.mysql-flexible-properties.mysql-vnet-subnet-name
  virtual_network_name = var.vnet-name
  address_prefixes     = var.mysql-flexible-properties.mysql-vnet-subnet-address-prefixes
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "mysql-private-dns-zone" {
  resource_group_name = var.resource-group-properties.rg-name

  name = var.mysql-flexible-properties.mysql-private-dns-zone-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql-private-dns-zone-virtual-network-link" {
  resource_group_name = var.resource-group-properties.rg-name

  name                  = var.mysql-flexible-properties.mysql-private-dns-zone-virtual-network-link-name
  private_dns_zone_name = azurerm_private_dns_zone.mysql-private-dns-zone.name
  virtual_network_id    = var.vnet-id
}

resource "azurerm_mysql_flexible_server" "mysql-flexible-server" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                   = var.mysql-flexible-properties.mysql-flexible-server-name
  administrator_login    = var.mysql-flexible-properties.mysql-administrator-login
  administrator_password = var.mysql-flexible-properties.mysql-administrator-password
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.mysql-vnet-private-subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.mysql-private-dns-zone.id
  sku_name               = var.mysql-flexible-properties.mysql-sku-name
  version                = var.mysql-flexible-properties.mysql-version

  storage {
    iops    = 360
    size_gb = 20
  }

  depends_on = [
    azurerm_subnet.mysql-vnet-private-subnet,
    azurerm_private_dns_zone_virtual_network_link.mysql-private-dns-zone-virtual-network-link
  ]
}

resource "azurerm_mysql_flexible_database" "mysql-flexible-database" {
  resource_group_name = var.resource-group-properties.rg-name

  name        = var.mysql-flexible-properties.mysql-flexible-database-name
  server_name = azurerm_mysql_flexible_server.mysql-flexible-server.name
  charset     = "utf8mb4"
  collation   = "utf8mb4_unicode_ci"
}