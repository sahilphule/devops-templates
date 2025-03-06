resource "duplocloud_tenant" "duplocloud-tenant" {
  account_name = var.duplocloud-tenant-properties.tenant-account-name
  plan_id      = var.duplocloud-tenant-properties.tenant-plan-id
}
