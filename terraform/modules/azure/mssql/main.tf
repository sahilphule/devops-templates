resource "azurerm_mssql_server" "mssql_server" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location

  name                          = var.mssql-properties.mssql-server-name
  version                       = var.mssql-properties.mssql-server-version
  administrator_login           = var.mssql-properties.mssql-server-login
  administrator_login_password  = var.mssql-properties.mssql-server-login-password
  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "mssql_database" {
  name        = var.mssql-properties.mssql-database-name
  server_id   = azurerm_mssql_server.mssql_server.id
  max_size_gb = 1

  depends_on = [
    azurerm_mssql_server.mssql_server
  ]
}

resource "azurerm_private_endpoint" "vpc-db-subnet-endpoint" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name      = var.mssql-properties.vpc-db-subnet-endpoint-name
  subnet_id = var.vnet-db-subnet-id

  private_service_connection {
    name                           = "vnet-db-private-connection"
    private_connection_resource_id = azurerm_mssql_server.mssql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}