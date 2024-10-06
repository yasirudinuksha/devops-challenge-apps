module "nginx-helm" {
  source           = "../../modules/helm/helm-release"
  chart            = "ingress-nginx"
  create_namespace = true
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart_version    = "4.11.0"
  namespace        = "ingress"

  set_values = {
    "controller.service.externalTrafficPolicy" : "Local"
    "controller.service.annotations.service.beta.kubernetes.io/azure-load-balancer-internal" : "true"
  }
}

module "cert-manager-helm" {
  source           = "../../modules/helm/helm-release"
  chart            = "cert-manager"
  chart_version    = "v1.15.1"
  create_namespace = true
  name             = "cert-manager"
  namespace        = "cert-manager"
  repository       = "https://charts.jetstack.io"

  set_values = {
    "installCRDs" = "true"
  }
}

module "cluster_issuer" {
  source             = "../../modules/kubernetes/cluster-issuer"
  email              = "devops@surge.global"
  ingress_class_name = "nginx"
  name               = "letsencrypt-prod"
  depends_on = [
    module.cert-manager-helm
  ]
}

module "frontend_namespace" {
  source = "../../modules/kubernetes/namespace-v1"
  name   = "frontend"
}

module "backend_namespace" {
  source = "../../modules/kubernetes/namespace-v1"
  name   = "backend"
}