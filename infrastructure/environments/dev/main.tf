#Resource Groups

module "network_rg" {
  source  = "../../modules/azure/resource-group"
  context = local.context
  usage   = "network"
  tags    = local.tags
}

module "container_registry_rg" {
  source  = "../../modules/azure/resource-group"
  context = local.context
  usage   = "acr"
  tags    = local.tags
}

module "aks_rg" {
  source  = "../../modules/azure/resource-group"
  context = local.context
  usage   = "aks"
  tags    = local.tags
}

module "database_rg" {
  source  = "../../modules/azure/resource-group"
  context = local.context
  usage   = "db"
  tags    = local.tags
}

#Network resources

module "virtual_network" {
  source              = "../../modules/azure/virtual-network"
  context             = local.context
  address_space       = local.vnet_address_space
  resource_group_name = module.network_rg.resource_group.name
  usage               = "webapp"
  tags                = local.tags
}


#Subnet configs

module "application_subnet" {
  source               = "../../modules/azure/subnet"
  context              = local.context
  resource_group_name  = module.network_rg.resource_group.name
  virtual_network_name = module.virtual_network.virtual_network.name
  usage                = "app"
  tags                 = local.tags

  address_prefixes = [cidrsubnet(local.vnet_address_space, 8, 1)]
}

module "db_subnet" {
  source               = "../../modules/azure/subnet"
  context              = local.context
  resource_group_name  = module.network_rg.resource_group.name
  virtual_network_name = module.virtual_network.virtual_network.name
  usage                = "db"
  tags                 = local.tags

  address_prefixes = [cidrsubnet(local.vnet_address_space, 8, 2)]

}

#Container Registry

module "container_registry" {
  source              = "../../modules/azure/container-registry"
  context             = local.context
  resource_group_name = module.container_registry_rg.resource_group.name
  usage               = "intl"
  sku                 = "Standard"
  admin_enabled       = true
  tags                = local.tags
}

#Kubernetes Clusters

module "kubernetes_service" {
  source  = "../../modules/azure/kubernetes-service"
  context = local.context

  default_node_pool = {
    name           = "nodepool"
    node_count     = 1
    vm_size        = "Standard_B2s"
    vnet_subnet_id = module.application_subnet.subnet.id
  }
  identity = {
    type = "SystemAssigned"
  }
  resource_group_name = module.aks_rg.resource_group.name
  usage               = "intl"

  node_resource_group = "rg-wa-aks-node-dev-cus"

  tags = local.tags
}

module "acrpull_role_assignment" {
  source                           = "../../modules/azure/role-assignment"
  principal_id                     = module.kubernetes_service.kubelet_identity[0].object_id
  scope                            = module.container_registry.container_registry.id
  skip_service_principal_aad_check = true
  usage                            = "acrpull"
  role_definition_name             = "AcrPull"
}

#PostgreSQL Database

module "postgresql_flexible" {
  source                 = "../../modules/azure/postgresql-flexible"
  administrator_login    = var.psql_administrator_login
  administrator_password = var.psql_administrator_password
  context                = local.context
  postgresql_version     = "16"
  resource_group_name    = module.database_rg.resource_group.name
  sku_name               = "B_Standard_B1ms"
  tags                   = local.tags
  usage                  = "intl"
  zone                   = "3"

  databases = {
    wa-db = {
      charset   = "UTF8"
      collation = "en_US.utf8"
    }
  }
}

module "postgresql_private_endpoint" {
  source                         = "../../modules/azure/private-endpoint"
  context                        = local.context
  private_connection_resource_id = module.postgresql_flexible.postgresql_flexible_server.id
  resource_group_name            = module.network_rg.resource_group.name
  subnet_id                      = module.db_subnet.subnet.id
  usage                          = "psql"

  subresource_names = ["postgresqlServer"]
}