locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # aks properties
  aks-properties = {
    aks-cluster-name                     = "aks-cluster"
    aks-kubernetes-version               = "1.30.1"
    aks-dns-prefix                       = "aks-cluster"
    aks-sku-tier                         = "Free"
    aks-private-cluster-enabled          = false
    aks-http-application-routing-enabled = true

    aks-default-node-pool-name                        = "defnodepool"
    aks-default-node-pool-type                        = "VirtualMachineScaleSets"
    aks-default-node-pool-vm-size                     = "Standard_DS2_v2"
    aks-default-node-pool-auto-scaling-enabled        = false
    aks-default-node-pool-min-count                   = null
    aks-default-node-pool-max-count                   = null
    aks-default-node-pool-node-count                  = 1
    aks-default-node-pool-node-public-ip-enabled      = false
    aks-default-node-pool-temporary-name-for-rotation = "nodepoolrot"

    aks-cluster-node-pool-name                   = "nodepool"
    aks-cluster-node-pool-vm-size                = "Standard_DS2_v2"
    aks-cluster-node-pool-mode                   = "User"
    aks-cluster-node-pool-auto-scaling-enabled   = false
    aks-cluster-node-pool-min-count              = null
    aks-cluster-node-pool-max-count              = null
    aks-cluster-node-pool-node-count             = 1
    aks-cluster-node-pool-node-public-ip-enabled = false
  }
}
