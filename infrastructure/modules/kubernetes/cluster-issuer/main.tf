resource "kubernetes_manifest" "cluster_issuer" {
  manifest = {
    apiVersion = var.api_version
    kind       = "ClusterIssuer"
    metadata = {
      name = var.name
    }
    spec = {
      acme = {
        email = var.email
        privateKeySecretRef = {
          name = "${terraform.workspace}-issuer-account-key"
        }
        server  = var.server
        solvers = [
          {
            http01 = {
              ingress = {
                ingressClassName = var.ingress_class_name
              }
            }
          },
        ]
      }
    }
  }
}