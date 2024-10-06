#Terraform documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#default_node_pool

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

variable "default_node_pool" {
  description = "Default Node Pool configurations"
  type = object({
    name = string
    node_count = number
    vm_size = string
    vnet_subnet_id = string
  })

  validation {
    condition = contains([
      "Standard_D2_v2",
      "Standard_DS1_v2",
      "Standard_DS2_v2",
      "Standard_DS3_v2",
      "Standard_DS4_v2",
      "Standard_DS5_v2",
      "Standard_D2s_v3",
      "Standard_D4s_v3",
      "Standard_D8s_v3",
      "Standard_D2as_v5",
      "Standard_B2s",
      "Standard_B2as_v2",
      "standard_ds2_v2_promo"
      # Add more VM sizes as needed
    ], var.default_node_pool.vm_size)
    error_message = "The vm_size must be one of the allowed Azure VM sizes."
  }
}

variable "identity" {
  description = "Identity configuration"
  type = object({
    type = string // here the "type" is "type of the identity"
  })

  validation {
    condition = contains([
      "SystemAssigned",
      "UserAssigned"
    ], var.identity.type)
    error_message = "Identity type must be either UserAssigned or SystemAssigned"
  }
}

variable "usage" {
  description = "Usage of this Kubernetes Service"
  type = string
}

variable "node_resource_group" {
  description = "The name of the Resource Group where the Kubernetes Nodes should exist"
  type = string
}

variable "tags" {
  description = "Tags need to attach to this kubernetes service"
  type = map(string)
  default = {}
}