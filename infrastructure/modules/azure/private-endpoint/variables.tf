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

variable "subnet_id" {
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint."
  type = string
}

variable "private_connection_resource_id" {
  description = "The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to."
  type = string
}

variable "subresource_names" {
  description = "A list of subresource names which the Private Endpoint is able to connect to."
  type = list(string)
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