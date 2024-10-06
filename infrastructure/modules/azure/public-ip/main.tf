locals {
  resource_type          = "pip"
  resource_name_template = "${local.resource_type}-${var.context.business_unit}-${var.usage}-${var.context.environment}-${var.context.location_abbr}"
  tags                   = var.tags
}

resource "azurerm_public_ip" "public_ip" {
  allocation_method   = var.allocation_method
  location            = var.context.location
  name                = local.resource_name_template
  resource_group_name = var.resource_group_name
}