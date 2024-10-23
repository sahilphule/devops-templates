variable "container-app-properties" {
  description = "container app properties"
  type        = map(any)
}

variable "resource-group-properties" {
  description = "resource group properties"
  type        = map(any)
}

variable "vnet-public-subnet-id" {
  description = "vnet-public-subnet-id"
  type        = any
}