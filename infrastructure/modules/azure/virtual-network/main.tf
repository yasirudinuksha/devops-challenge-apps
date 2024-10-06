#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network#address_space

locals {
  resource_type          = "vnet"
  resource_name_template = "${local.resource_type}-${var.context.business_unit}-${var.usage}-${var.context.environment}-${var.context.location_abbr}"
  tags                   = var.tags
}

resource "azurerm_virtual_network" "virtual_network" {
  address_space = [var.address_space]

  location            = var.context.location
  name                = local.resource_name_template
  resource_group_name = var.resource_group_name
  tags                = local.tags
}