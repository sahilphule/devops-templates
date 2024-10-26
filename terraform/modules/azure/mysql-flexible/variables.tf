variable "mysql-properties" {
  description = "azure mysql properties"
  type        = any
}

variable "resource-group-properties" {
  description = "resource group properties"
  type        = map(any)
}

variable "vnet-id" {
  description = "virtual network id"
  type        = any
}

variable "vnet-name" {
  description = "virtual network name"
  type        = string
}