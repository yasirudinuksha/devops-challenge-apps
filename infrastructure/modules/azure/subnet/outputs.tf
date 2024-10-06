output "subnet" {
  description = "The subnet information for downstream modules"
  value = {
    id = azurerm_subnet.subnet.id
    name = azurerm_subnet.subnet.name
    address_prefixes = azurerm_subnet.subnet.address_prefixes
  }
}