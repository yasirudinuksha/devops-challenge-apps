#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network#address_space

variable "context" {
  description = "The environment context for this operation"
  type = object({
    environment   = string
    business_unit = string
    location      = string
    location_abbr = string
  })
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = string
}

variable "usage" {
  description = "Usage of this Vnet"
  type        = string
}

variable "tags" {
  description = "Tags need to attach to this VNet"
  type = map(string)
  default = {}
}