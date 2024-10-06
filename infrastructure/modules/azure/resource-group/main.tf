#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group#location

locals {
  resource_type          = "rg"
  resource_name_template = "${local.resource_type}-${var.context.business_unit}-${var.usage}-${var.context.environment}-${var.context.location_abbr}"
  tags                   = var.tags
}

resource "azurerm_resource_group" "resource_group" {
  name     = local.resource_name_template
  location = var.context.location
  tags     = local.tags
}
