resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.common_component_name}-${local.environment}-${module.azure_region.location_short}-01"
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  address_space       = local.vnet_address_space
  tags                = local.tags
}

resource "azurerm_virtual_network_peering" "vnet-to-hub" {
  name                      = "${local.environment}-to-hub"
  resource_group_name       = module.resource_group.rg_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = data.terraform_remote_state.hub_resources.outputs.hub_vnet_id
}

resource "azurerm_virtual_network_peering" "hub-to-vnet" {
  name                      = "hub-to-${local.environment}"
  resource_group_name       = data.terraform_remote_state.hub_resources.outputs.hub_resource_group_name
  virtual_network_name      = data.terraform_remote_state.hub_resources.outputs.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "app_service_dns_link" {
  name                  = "dns-link-${azurerm_virtual_network.vnet.name}"
  resource_group_name   = data.terraform_remote_state.hub_resources.outputs.hub_resource_group_name
  private_dns_zone_name = data.terraform_remote_state.hub_resources.outputs.app_service_dns_name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  name                  = "dns-link-${azurerm_virtual_network.vnet.name}"
  resource_group_name   = data.terraform_remote_state.hub_resources.outputs.hub_resource_group_name
  private_dns_zone_name = data.terraform_remote_state.hub_resources.outputs.sql_dns_name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

module "subnets" {
  source              = "../modules/subnet"
  for_each            = local.subnets
  address_prefix      = each.value
  component_name      = each.key
  environment         = local.environment
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  vnet_name           = azurerm_virtual_network.vnet.name
}

module "db_nsg" {
  source              = "../modules/nsg"
  allow_ports         = ["1433"]
  allow_subnets       = module.subnets["be-ob"].subnet_address_prefixes
  component_name      = local.db_component_name
  environment         = local.environment
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  subnet_id           = module.subnets["db"].subnet_id
  tags                = local.tags
}

module "be_nsg" {
  source              = "../modules/nsg"
  allow_ports         = ["443"]
  allow_subnets       = module.subnets["fe-ob"].subnet_address_prefixes
  component_name      = local.be_component_name
  environment         = local.environment
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  subnet_id           = module.subnets["be"].subnet_id
  tags                = local.tags
}

module "be_ob_nsg" {
  source              = "../modules/nsg"
  component_name      = "be-ob"
  environment         = local.environment
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  subnet_id           = module.subnets["be-ob"].subnet_id
  tags                = local.tags
}

module "fe_nsg" {
  source              = "../modules/nsg"
  allow_ports         = ["443"]
  allow_subnets       = data.terraform_remote_state.hub_resources.outputs.app_gateway_subnet_address_prefixes
  component_name      = local.fe_component_name
  environment         = local.environment
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  subnet_id           = module.subnets["fe"].subnet_id
  tags                = local.tags
}

module "fe_ob_nsg" {
  source              = "../modules/nsg"
  component_name      = "fe-ob"
  environment         = local.environment
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  subnet_id           = module.subnets["fe-ob"].subnet_id
  tags                = local.tags
}
