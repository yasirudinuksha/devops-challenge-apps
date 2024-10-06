#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group#location

variable "context" {
  description = "The environment context for this operation"
  type = object({
    environment   = string
    business_unit = string
    location      = string
    location_abbr = string
  })
}

variable "usage" {
  description = "Usage of this resource group"
  type        = string
}

variable "tags" {
  description = "Tags need to attach to this resource group"
  type = map(string)
  default = {}
}
