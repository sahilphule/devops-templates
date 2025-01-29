data "azuread_client_config" "client_config" {}

data "azuread_user" "user" {
  user_principal_name = var.user-principal-name
}
