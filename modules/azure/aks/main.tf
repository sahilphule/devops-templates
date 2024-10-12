resource "azurerm_kubernetes_cluster" "aks-cluster" {
  location = var.resource-group-properties.resource-group-location
  resource_group_name = var.resource-group-properties.resource-group-name
  
  name = var.aks-properties.aks-cluster-name
  kubernetes_version = var.aks-properties.kubernetes-version
  dns_prefix = var.aks-properties.aks-cluster-name
  node_resource_group = var.aks-properties.node-resource-group

  default_node_pool {
    name = "nodepool"
    vm_size = var.aks-properties.vm-size
    node_count = var.aks-properties.node-count
    type = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin = "kubenet"
  }
}