data "azuread_client_config" "client_config" {}

data "azuread_user" "user" {
  user_principal_name = var.user-principal-name
}

locals {
  owners = [
    data.azuread_client_config.client_config.object_id,
    data.azureadata.azuread_user.user.object_id
  ]
}

resource "azuread_application" "application" {
  display_name = var.application-display-name
  owners       = local.owners
}

resource "azuread_application_password" "application-password" {
  application_id = azuread_application.application.object_id
}

resource "azuread_service_principal" "service-principal" {
  client_id                    = azuread_application.application.client_id
  app_role_assignment_required = false
  owners                       = local.owners
}

resource "azuread_service_principal_password" "service-principal-password" {
  service_principal_id = azuread_service_principal.service-principal.object_id
}