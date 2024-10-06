locals {
  context       = {
    business_unit = "wa"
    environment   = "dev"
    location_abbr = "cus"
    location      = "centralus"
  }

  tags          = {
    provisioner   = "terraform"
    environment   = local.context.environment
    location      = local.context.location_abbr
    business_unit = local.context.business_unit
  }

  vnet_address_space =  "10.10.0.0/16"

  host = module.kubernetes_service.cluster_credentials.host
  client_certificate = base64decode(module.kubernetes_service.cluster_credentials.client_certificate)
  client_key = base64decode(module.kubernetes_service.cluster_credentials.client_key)
  cluster_ca_certificate = base64decode(module.kubernetes_service.cluster_credentials.cluster_ca_certificate)
}