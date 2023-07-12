module "azure_region" {
  source       = "claranet/regions/azurerm"
  azure_region = local.location
}

module "resource_group" {
  source = "../modules/resource_group"

  component_name = local.common_component_name
  environment    = local.environment
  location       = local.location
  tags           = local.tags
}