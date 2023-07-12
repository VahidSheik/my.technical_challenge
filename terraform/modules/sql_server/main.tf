module "azure_region" {
  source       = "claranet/regions/azurerm"
  azure_region = var.location
}

resource "azurerm_mssql_server" "sql_server" {
  name                          = "sql-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = false

  azuread_administrator {
    azuread_authentication_only = true
    login_username              = var.azuread_admin_username
    object_id                   = var.azuread_admin_object_id
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "privateendpoint" {
  name                = "pe-sql-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id

  private_dns_zone_group {
    name                 = "dns-zone-sql-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  private_service_connection {
    name                           = "pvt-svc-sql-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}