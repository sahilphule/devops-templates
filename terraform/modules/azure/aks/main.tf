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
  }

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
