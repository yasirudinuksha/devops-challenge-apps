locals {
  resource_type          = "vm"
  resource_name_template = "${local.resource_type}-${var.context.business_unit}-${var.usage}-${var.context.environment}-${var.context.location_abbr}"
  tags                   = var.tags
}

resource "azurerm_virtual_machine" "virtual_machine" {
  location            = var.context.location
  name                = local.resource_name_template
  network_interface_ids = [azurerm_network_interface.network_interface.id]
  resource_group_name = var.resource_group_name
  vm_size             = var.vm_size

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name          = "${local.resource_name_template}-disk"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}

resource "azurerm_network_interface" "network_interface" {
  location            = var.context.location
  name                = "${local.resource_name_template}-nic"
  resource_group_name = var.resource_group_name


  ip_configuration {
    name                          = "${local.resource_name_template}-ipconfig"
    private_ip_address_allocation = var.private_ip_address_allocation
    subnet_id                     = var.subnet_id
    public_ip_address_id          = var.public_ip_address_id
  }
}