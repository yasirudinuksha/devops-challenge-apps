#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#address_prefixes

locals {
  resource_type          = "snet"
  resource_name_template = "${local.resource_type}-${var.context.business_unit}-${var.usage}-${var.context.environment}-${var.context.location_abbr}"
}

resource "azurerm_subnet" "subnet" {
  address_prefixes     = var.address_prefixes
  name                 = local.resource_name_template
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name

  dynamic "delegation" {
    for_each = var.service_delegation_name != "" ? [1] : []

    content {
      name = "${local.resource_name_template}-delegation"

      service_delegation {
        name = var.service_delegation_name
      }
    }
  }
}