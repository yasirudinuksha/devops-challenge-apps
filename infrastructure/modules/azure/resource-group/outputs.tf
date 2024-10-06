output "resource_group" {
  description = "The resource group information for downstream modules"
  value = {
    name     = azurerm_resource_group.resource_group.name
    location = azurerm_resource_group.resource_group.location
    id       = azurerm_resource_group.resource_group.id
  }
}
