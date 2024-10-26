# resource "local_file" "kubeconfig" {
#   depends_on = [azurerm_kubernetes_cluster.aks-cluster]
#   filename   = "kubeconfig"
#   content    = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
# }