variable "container-app-properties" {
  description = "container app properties"
  type        = any
}

variable "resource-group-properties" {
  description = "resource group properties"
  type        = any
}

variable "vnet-public-subnet-id" {
  description = "virtual network public subnet id"
  type        = any
}

variable "acr-id" {
  description = "acr id"
  type        = any
}

variable "acr-name" {
  description = "acr name"
  type        = string
}