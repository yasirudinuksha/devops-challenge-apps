#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment

variable "usage" {
  description = "usage of this role assignment"
  type        = string
}

variable "principal_id" {
  description = "The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created."
  type = string
}

variable "scope" {
  description = " The scope at which the Role Assignment applies to."
  type = string
}

variable "role_definition_name" {
  description = "The name of a built-in Role."
  type = string
}

variable "skip_service_principal_aad_check" {
  description = "If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag."
  type = bool
}