# resource "azurerm_user_assigned_identity" "user-assigned-identity" {
#   resource_group_name = var.resource-group-properties.rg-name
#   location = var.resource-group-properties.rg-location

#   name = var.aks-properties.aks-user-assigned-identity-name
# }

# resource "azurerm_role_assignment" "aks-acr-pull" {
#   scope                = var.acr-id
#   role_definition_name = "AcrPull"
#   principal_id = azurerm_user_assigned_identity.user-assigned-identity.principal_id
#   # principal_id         = azurerm_kubernetes_cluster.aks-cluster.kubelet_identity[0].object_id
# }

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  location            = var.resource-group-properties.rg-location
  resource_group_name = var.resource-group-properties.rg-name

  name                             = var.aks-properties.aks-cluster-name
  kubernetes_version               = var.aks-properties.aks-kubernetes-version
  dns_prefix                       = var.aks-properties.aks-dns-prefix
  sku_tier                         = var.aks-properties.aks-sku-tier
  private_cluster_enabled          = var.aks-properties.aks-private-cluster-enabled
  http_application_routing_enabled = var.aks-properties.aks-http-application-routing-enabled

  default_node_pool {
    name                        = var.aks-properties.aks-default-node-pool-name
    type                        = var.aks-properties.aks-default-node-pool-type
    vm_size                     = var.aks-properties.aks-default-node-pool-vm-size
    auto_scaling_enabled        = var.aks-properties.aks-default-node-pool-auto-scaling-enabled
    min_count                   = var.aks-properties.aks-default-node-pool-min-count
    max_count                   = var.aks-properties.aks-default-node-pool-max-count
    node_count                  = var.aks-properties.aks-default-node-pool-node-count
    node_public_ip_enabled      = var.aks-properties.aks-default-node-pool-node-public-ip-enabled
    temporary_name_for_rotation = var.aks-properties.aks-default-node-pool-temporary-name-for-rotation

    vnet_subnet_id = var.vnet-public-subnet-id
  }

  identity {
    type = "SystemAssigned"
    # identity_ids = [azurerm_user_assigned_identity.user-assigned-identity.id]
  }

  # service_principal {
  #   client_id     = var.aks-properties.aks-service-principal-client-id
  #   client_secret = var.aks-properties.aks-service-principal-client-secret
  # }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "aks-cluster-node-pool" {
  name                   = var.aks-properties.aks-cluster-node-pool-name
  vm_size                = var.aks-properties.aks-cluster-node-pool-vm-size
  mode                   = var.aks-properties.aks-cluster-node-pool-mode
  auto_scaling_enabled   = var.aks-properties.aks-cluster-node-pool-auto-scaling-enabled
  min_count              = var.aks-properties.aks-cluster-node-pool-min-count
  max_count              = var.aks-properties.aks-cluster-node-pool-max-count
  node_count             = var.aks-properties.aks-cluster-node-pool-node-count
  node_public_ip_enabled = var.aks-properties.aks-cluster-node-pool-node-public-ip-enabled

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-cluster.id
  vnet_subnet_id        = var.vnet-public-subnet-id
}

# resource "azurerm_dns_a_record" "aks-app-gw" {
#   name                = "aks-app-gw"
#   zone_name           = azurerm_dns_zone.mydomain.name
#   resource_group_name = var.resource-group-properties.rg-name
#   ttl                 = 300
#   records             = [azurerm_public_ip.appgw.ip_address]
# }