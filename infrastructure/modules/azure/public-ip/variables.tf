variable "context" {
  description = "The environment context for this operation"
  type = object({
    environment   = string
    business_unit = string
    location      = string
    location_abbr = string
  })
}

variable "allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  type = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type = string
}

variable "usage" {
  description = "Usage of this IP"
  type        = string
}

variable "tags" {
  description = "Tags need to attach to this IP"
  type = map(string)
  default = {}
}
