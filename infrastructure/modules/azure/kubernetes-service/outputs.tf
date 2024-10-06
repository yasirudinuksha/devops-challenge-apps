output "kubernetes_service" {
  description = "The details of the kubernetes service for downstream modules"
  value = {
    id = azurerm_kubernetes_cluster.kubernetes_cluster.id
    name = azurerm_kubernetes_cluster.kubernetes_cluster.name
  }
}

output "cluster_credentials" {
  value = {
    client_key = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_key
    client_certificate = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_certificate
    cluster_ca_certificate = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.cluster_ca_certificate
    host = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.host
  }
}

output "oidc_issuer" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.oidc_issuer_url
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_identity
}