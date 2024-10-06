#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry

locals {
  resource_type          = "cr"
  resource_name_template = "${local.resource_type}${var.context.business_unit}${var.usage}${var.context.environment}${var.context.location_abbr}"
  tags                   = var.tags
}

resource "azurerm_container_registry" "container_registry" {
  location            = var.context.location
  name                = local.resource_name_template
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  tags                = local.tags
}

