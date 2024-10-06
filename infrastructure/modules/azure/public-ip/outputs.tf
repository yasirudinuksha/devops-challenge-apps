output "public_ip" {
  description = "The public IP information for downstream modules"
  value = {
    name     = azurerm_public_ip.public_ip.name
    id       = azurerm_public_ip.public_ip.id
  }
}
