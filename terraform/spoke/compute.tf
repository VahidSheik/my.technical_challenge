resource "azurerm_service_plan" "service_plan" {
  name                = "asp-${local.common_component_name}-${local.environment}-${module.azure_region.location_short}-01"
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  os_type             = "Windows"
  sku_name            = local.app_sku_name
}

module "frontend_app" {
  source = "../modules/app_service"

  component_name             = "fe"
  environment                = local.environment
  location                   = local.location
  private_dns_zone_id        = data.terraform_remote_state.hub_resources.outputs.app_service_dns_id
  resource_group_name        = module.resource_group.rg_name
  service_plan_id            = azurerm_service_plan.service_plan.id
  vnet_integration_subnet_id = module.subnets["fe-ob"].subnet_id
  private_endpoint_subnet_id = module.subnets["fe"].subnet_id
  tags                       = local.tags
}

module "backend" {
  source = "../modules/app_service"

  component_name             = "be"
  environment                = local.environment
  location                   = local.location
  private_dns_zone_id        = data.terraform_remote_state.hub_resources.outputs.app_service_dns_id
  resource_group_name        = module.resource_group.rg_name
  service_plan_id            = azurerm_service_plan.service_plan.id
  vnet_integration_subnet_id = module.subnets["be-ob"].subnet_id
  private_endpoint_subnet_id = module.subnets["be"].subnet_id
  tags                       = local.tags
}