terraform {
  required_version = ">= 1.10.3"

  # For duplocloud
  required_providers {
    duplocloud = {
      source  = "duplocloud/duplocloud"
      version = "0.11.0"
    }
  }
}

provider "duplocloud" {
  host      = local.duplocloud-properties.duplocloud-host
  tenant_id = local.duplocloud-properties.duplocloud-tenant-id
  token     = local.duplocloud-properties.duplocloud-token
}
