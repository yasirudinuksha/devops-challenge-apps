resource "kubernetes_namespace_v1" "namespace_v1" {
  metadata {
    name = var.name
  }
}