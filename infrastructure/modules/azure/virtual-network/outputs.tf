output "virtual_network" {
  description = "The vnet information for downstream modules"
  value = {
    id            = azurerm_virtual_network.virtual_network.id
    name          = azurerm_virtual_network.virtual_network.name
    address_space = azurerm_virtual_network.virtual_network.address_space
  }
}