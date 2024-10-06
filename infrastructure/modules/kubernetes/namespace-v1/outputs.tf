output "namespace_v1" {
  description = "Namespace information for downstream modules"
  value = {
    name = kubernetes_namespace_v1.namespace_v1.metadata[0].name
  }
}