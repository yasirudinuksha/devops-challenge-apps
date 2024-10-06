#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry

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

variable "sku" {
  description = "The SKU name of the container registry"
  type = string
  validation {
    condition = contains(["Basic","Standard","Premium"],var.sku)
    error_message = "ACR SKU must be either Basic, Standard or Premium"
  }
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled. Defaults to false."
  type = bool
  default = false
}

variable "usage" {
  description = "Usage of this Container Registry"
  type = string
  default = ""
}

variable "tags" {
  description = "Tags need to attach to this resource group"
  type = map(string)
  default = {}
}
