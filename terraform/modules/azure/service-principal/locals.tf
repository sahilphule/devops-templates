locals {
  owners = [
    data.azuread_client_config.client_config.object_id,
    data.azureadata.azuread_user.user.object_id
  ]
}
