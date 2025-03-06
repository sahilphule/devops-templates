resource "duplocloud_infrastructure" "duplocloud-infrastructure" {
  infra_name        = var.duplocloud-infrastructure-properties.infra-name
  cloud             = var.duplocloud-infrastructure-properties.cloud
  region            = var.duplocloud-infrastructure-properties.region
  enable_k8_cluster = var.duplocloud-infrastructure-properties.enable-k8-cluster
  address_prefix    = var.duplocloud-infrastructure-properties.address-prefix
}
