variable "mssql-properties" {
  description = "mssql properties"
  type        = map(any)
}

variable "resource-group-properties" {
  description = "resource group properties"
  type        = map(any)
}

variable "vnet-db-subnet-id" {
  description = "vnet db subnet id"
  type        = any
}