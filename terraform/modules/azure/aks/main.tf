resource "azurerm_kubernetes_cluster" "aks-cluster" {
  location            = var.resource-group-properties.rg-location
  resource_group_name = var.resource-group-properties.rg-name

  name                = var.aks-properties.aks-cluster-name
  kubernetes_version  = var.aks-properties.aks-kubernetes-version
  dns_prefix          = var.aks-properties.aks-cluster-name
  node_resource_group = var.aks-properties.aks-node-resource-group-name

  default_node_pool {
    name                  = "nodepool"
    type                  = "VirtualMachineScaleSets"
    vm_size               = var.aks-properties.aks-vm-size
    node_count            = 1
    vnet_subnet_id        = var.vnet-public-subnet-id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }

  # addon_profile {
  #   http_application_routing {
  #     enabled = true
  #   }    
  # }
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