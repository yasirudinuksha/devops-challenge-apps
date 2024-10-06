#Terraform Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#default_node_pool

locals {
  resource_type          = "aks"
  resource_name_template = "${local.resource_type}-${var.context.business_unit}-${var.usage}-${var.context.environment}-${var.context.location_abbr}"
  tags                   = var.tags
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  location            = var.context.location
  name                = local.resource_name_template
  resource_group_name = var.resource_group_name
  dns_prefix          = local.resource_name_template
  node_resource_group = var.node_resource_group

  default_node_pool {
    name           = var.default_node_pool.name
    vm_size        = var.default_node_pool.vm_size
    node_count     = var.default_node_pool.node_count
    vnet_subnet_id = var.default_node_pool.vnet_subnet_id
    temporary_name_for_rotation = "tempnodepool"

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }

  }

  identity {
    type = var.identity.type
  }

  tags = local.tags

}
