variable "resource-group-properties" {
  description = "resource group properties"
  type        = map(any)
}

variable "mssql-properties" {
  description = "mssql properties"
  type        = any
}

variable "vnet-name" {
  description = "virtual network name"
  type        = string
}

variable "vnet-public-subnet-id" {
  description = "virtual network public subnet id"
  type        = any
}