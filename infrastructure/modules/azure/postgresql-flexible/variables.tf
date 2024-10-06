#Terraform documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server

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

variable "sku_name" {
  description = "Name of the SKU of the DB server"
  type        = string
}

variable "postgresql_version" {
  description = "Version of the PostgreSQL server"
  type        = string

  validation {
    condition = contains(["14", "15", "16"], var.postgresql_version)
    error_message = "Selected Server version is incorrect, Valid values are 14, 15 and 16"
  }
}

variable "administrator_login" {
  description = "Username of the admin user of PSQL server"
  type        = string
}

variable "administrator_password" {
  description = "Password of the admin user of PSQL server"
  type        = string
}

variable "usage" {
  description = "Usage of this postgresql server"
  type        = string
  default     = ""
}

variable "zone" {
  description = "Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located."
  type        = string
}

variable "databases" {
  description = "Object map of databases inside the database server"
  type = map(object({
    charset   = string
    collation = string
  }))
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone to create the PostgreSQL Flexible Server."
  type        = string
  default     = ""
}

variable "delegated_subnet_id" {
  description = "The ID of the virtual network subnet to create the PostgreSQL Flexible Server."
  type        = string
  default     = ""
}

variable "public_network_access_enabled" {
  description = "Specifies whether this PostgreSQL Flexible Server is publicly accessible."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags need to attach to this postgresql server"
  type        = map(string)
  default     = {}
}