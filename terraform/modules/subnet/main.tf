module "azure_region" {
  source       = "claranet/regions/azurerm"
  azure_region = var.location
}

resource "azurerm_subnet" "subnet" {
  name                 = "snet-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.address_prefix]

  dynamic "delegation" {
    for_each = length(regexall(".*ob.*", var.component_name)) == 0 ? [] : [1]
    content {
      name = "delegation"
      service_delegation {
        name    = "Microsoft.Web/serverFarms"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
}