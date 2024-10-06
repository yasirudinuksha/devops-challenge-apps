#Terraform documentation : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment

resource "azurerm_role_assignment" "role_assignment" {
  role_definition_name = var.role_definition_name
  principal_id = var.principal_id
  scope        = var.scope
  skip_service_principal_aad_check = var.skip_service_principal_aad_check

}