resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.common_component_name}-${local.environment}-${module.azure_region.location_short}-01"
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  address_space       = local.vnet_address_space
  tags                = local.tags
}

resource "azurerm_private_dns_zone" "app_service_dns" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = module.resource_group.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "app_service_dns_link" {
  name                  = "dns-link-${azurerm_virtual_network.vnet.name}"
  resource_group_name   = module.resource_group.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.app_service_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone" "sql_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = module.resource_group.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  name                  = "dns-link-${azurerm_virtual_network.vnet.name}"
  resource_group_name   = module.resource_group.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns.name
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