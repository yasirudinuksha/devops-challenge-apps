locals {
  resource_type          = "pep"
  resource_name_template = "${local.resource_type}-${var.context.business_unit}-${var.usage}-${var.context.environment}-${var.context.location_abbr}"
  tags                   = var.tags
}

resource "azurerm_private_endpoint" "private_endpoint" {
  location            = var.context.location
  name                = local.resource_name_template
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    is_manual_connection = false
    name                 = "${local.resource_name_template}-psc"
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names = var.subresource_names
  }
}