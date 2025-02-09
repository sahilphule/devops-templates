locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # storage account properties
  storage-properties = {
    sa-name                          = "storage-account"
    sa-tier                          = "Standard"
    sa-kind                          = "StorageV2"
    sa-replication-type              = "LRS"
    sa-access-tier                   = "Hot"
    sa-https-traffic-only-enabled    = true
    sa-public-network-access-enabled = true

    sa-network-rules-count          = 1
    sa-network-rules-default-action = "Allow"
    sa-network-rules-bypass         = ["Metrics"] # Metrics, Logging, AzureServices (Default), None

    sc-count                 = 1
    sc-name                  = ["storage-container"]
    sc-container-access-type = "private"

    sb-object-name        = "storage-blob-object"
    sb-object-type        = "Block"
    sb-object-source-path = "~/Desktop/"
  }
}
