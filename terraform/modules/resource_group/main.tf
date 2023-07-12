module "azure_region" {
  source       = "claranet/regions/azurerm"
  azure_region = var.location
}

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
  location = var.location
  tags     = var.tags
}