#Terraform documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server

locals {
  resource_type          = "psql"
  resource_name_template = "${local.resource_type}-${var.context.business_unit}-${var.usage}-${var.context.environment}-${var.context.location_abbr}"
  tags                   = var.tags
}

resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  location            = var.context.location
  name                = local.resource_name_template
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name
  version  = var.postgresql_version
  zone     = var.zone

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  delegated_subnet_id           = var.delegated_subnet_id != "" ? var.delegated_subnet_id : null
  private_dns_zone_id           = var.private_dns_zone_id != "" ? var.private_dns_zone_id : null
  public_network_access_enabled = var.public_network_access_enabled

  tags = local.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_flexible_server_database" {
  for_each  = var.databases
  name      = each.key
  server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  charset   = each.value.charset
  collation = each.value.collation

  lifecycle {
    prevent_destroy = true
  }
}