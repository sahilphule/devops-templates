locals {
  # resource group properties
  resource-group-properties = {}

  # virtual network properties
  virtual-network-properties = {
    vnet-name = "vnet"
    vnet-address-space = [
      "10.1.0.0/16"
    ]
    vnet-public-subnet-name = "vnet-public-subnet"
    vnet-public-subnet-address-prefixes = [
      "10.1.0.0/23"
    ]
  }
}
