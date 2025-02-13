variable "resource-group-properties" {
  description = "resource group properties"
  type        = any
}

variable "container-app-properties" {
  description = "container app properties"
  type        = any
}

variable "container-app-environment-id" {
  description = "container app environment id"
  type        = string
}

variable "acr-login-server" {
  description = "acr login server"
  type        = string
}

variable "acr-admin-username" {
  description = "acr admin username"
  type        = string
}

variable "acr-admin-password" {
  description = "acr admin password"
  type        = any
}
