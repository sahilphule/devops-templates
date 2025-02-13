resource "azurerm_subnet" "mssql-subnet" {
  resource_group_name = var.resource-group-properties.rg-name

  name                 = var.mssql-properties.mssql-subnet-name
  virtual_network_name = var.vnet-name
  address_prefixes     = var.mssql-properties.mssql-subnet-address-prefixes
}

resource "azurerm_mssql_server" "mssql-server" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                          = var.mssql-properties.mssql-server-name
  version                       = var.mssql-properties.mssql-server-version
  administrator_login           = var.mssql-properties.mssql-server-login
  administrator_login_password  = var.mssql-properties.mssql-server-login-password
  public_network_access_enabled = false

  depends_on = [
    azurerm_subnet.mssql-subnet
  ]
}

resource "azurerm_mssql_database" "mssql-database" {
  name        = var.mssql-properties.mssql-database-name
  server_id   = azurerm_mssql_server.mssql-server.id
  max_size_gb = 1

  depends_on = [
    azurerm_mssql_server.mssql_server
  ]
}

resource "azurerm_private_endpoint" "mssql-subnet-private-endpoint" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name      = var.mssql-properties.mssql-subnet-private-endpoint-name
  subnet_id = azurerm_subnet.mssql-subnet.id

  private_service_connection {
    name                           = "mssql-subnet-private-connection"
    private_connection_resource_id = azurerm_mssql_server.mssql-server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}
