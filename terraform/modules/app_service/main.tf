module "azure_region" {
  source       = "claranet/regions/azurerm"
  azure_region = var.location
}

resource "azurerm_windows_web_app" "app_service" {
  name                      = "app-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  service_plan_id           = var.service_plan_id
  virtual_network_subnet_id = var.vnet_integration_subnet_id
  https_only                = true
  site_config {}
  tags = var.tags
}

resource "azurerm_private_endpoint" "privateendpoint" {
  name                = "pe-app-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id

  private_dns_zone_group {
    name                 = "dns-zone-app-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  private_service_connection {
    name                           = "pvt-svc-app-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
    private_connection_resource_id = azurerm_windows_web_app.app_service.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}