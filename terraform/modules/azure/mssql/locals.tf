locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-name             = module.virtual-network.vnet-name
  # vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # mssql properties
  mssql-properties = {
    mssql-subnet-name             = "mssql-subnet"
    mssql-subnet-address-prefixes = [""]

    mssql-server-name           = "mssql-server"
    mssql-server-version        = ""
    mssql-server-login          = ""
    mssql-server-login-password = ""
    mssql-database-name         = "mssql-database"

    mssql-subnet-private-endpoint-name = "mssql-subnet-private-endpoint"
  }
}
