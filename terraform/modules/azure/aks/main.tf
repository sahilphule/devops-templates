resource "azurerm_kubernetes_cluster" "aks-cluster" {
  location            = var.resource-group-properties.rg-location
  resource_group_name = var.resource-group-properties.rg-name

  name                    = var.aks-properties.aks-cluster-name
  kubernetes_version      = var.aks-properties.aks-kubernetes-version
  dns_prefix              = var.aks-properties.aks-dns-prefix
  sku_tier                = var.aks-properties.aks-sku-tier
  private_cluster_enabled = var.aks-properties.aks-private-cluster-enabled

  default_node_pool {
    name                        = var.aks-properties.aks-default-node-pool-name
    type                        = var.aks-properties.aks-default-node-pool-type
    vm_size                     = var.aks-properties.aks-default-node-pool-vm-size
    node_count                  = var.aks-properties.aks-default-node-pool-node-count
    temporary_name_for_rotation = var.aks-properties.aks-default-node-pool-temporary-name-for-rotation
    vnet_subnet_id              = var.vnet-public-subnet-id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }
}

# resource "azurerm_kubernetes_cluster_node_pool" "k8s-worker" {
#   for_each = var.nodepools

#   name                  = each.value.name
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-cluster.id
#   vm_size               = each.value.vm_size
#   min_count             = each.value.min_count
#   max_count             = each.value.max_count
#   enable_auto_scaling   = each.value.enable_auto_scaling
#   enable_node_public_ip = each.value.enable_node_public_ip
#   zones                 = each.value.zones
#   vnet_subnet_id        = var.vnet-public-subnet-id
#   node_labels = each.value.node_labels
# }