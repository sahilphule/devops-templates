data "duplocloud_native_host_image" "image" {
  tenant_id     = var.duplocloud-tenant-id
  is_kubernetes = false
}

resource "duplocloud_aws_host" "native" {
  tenant_id     = var.duplocloud-tenant-id
  friendly_name = "host01"

  image_id       = data.duplocloud_native_host_image.image.image_id
  capacity       = "t3a.medium"
  agent_platform = 0
  zone           = 0
  user_account   = duplocloud_tenant.tenant.account_name

  metadata {
    key   = "OsDiskSize"
    value = "20"
  }
}
