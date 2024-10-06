output "postgresql_flexible_server" {
  description = "Details of the postgresql flexible server for downstream modules"
  value = {
    id   = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
    name = azurerm_postgresql_flexible_server.postgresql_flexible_server.name
    fqdn = azurerm_postgresql_flexible_server.postgresql_flexible_server.fqdn
  }
}