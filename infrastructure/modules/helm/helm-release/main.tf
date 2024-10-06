#Terraform documentation : https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "helm_release" {
  chart = var.chart
  name  = var.name
  create_namespace = var.create_namespace
  namespace = var.namespace
  repository = var.repository
  version = var.chart_version

  dynamic "set" {
    for_each = var.set_values
    content {
      name  = set.key
      value = set.value
    }
  }
}