#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#address_prefixes

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
  type = string
}

variable "virtual_network_name" {
  description = "Name of the VNet"
  type = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet"
  type = list(string)
}

variable "usage" {
  description = "Usage of this subnet"
  type = string
}

variable "service_delegation_name" {
  description = "The name of service to delegate to."
  type = string
  default = ""
}

variable "tags" {
  description = "Tags need to attach to this subnet"
  type = map(string)
  default = {}
}