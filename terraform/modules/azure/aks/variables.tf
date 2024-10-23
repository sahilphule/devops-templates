variable "aks-properties" {
  description = "aks properties"
  type        = map(any)
}

variable "resource-group-properties" {
  description = "resource-group-properties"
  type        = map(any)
}

variable "vnet-public-subnet-id" {
  description = "vnet pubic subnet id"
  type        = any
}