module "sql_server" {
  source                     = "../modules/sql_server"
  azuread_admin_username     = local.sql_azuread_admin_username
  azuread_admin_object_id    = local.sql_azuread_admin_object_id
  component_name             = local.db_component_name
  environment                = local.environment
  location                   = local.location
  private_dns_zone_id        = data.terraform_remote_state.hub_resources.outputs.sql_dns_id
  resource_group_name        = module.resource_group.rg_name
  private_endpoint_subnet_id = module.subnets["db"].subnet_id
  tags                       = local.tags
}

module "sql_database" {
  source         = "../modules/sql_database"
  for_each       = local.databases
  component_name = each.value.database_initials
  environment    = local.environment
  location       = local.location
  sql_server_id  = module.sql_server.sql_server_id
  max_size_gb    = each.value.sql_max_size_gb
  sku_name       = each.value.sql_sku_name
  tags           = local.tags
}
