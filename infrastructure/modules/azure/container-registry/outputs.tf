output "container_registry" {
  description = "The container registry information for downstream modules"
  value = {
    name = azurerm_container_registry.container_registry.name
    id = azurerm_container_registry.container_registry.id
  }
}