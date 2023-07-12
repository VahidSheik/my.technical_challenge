module "azure_region" {
  source       = "claranet/regions/azurerm"
  azure_region = var.location
}

resource "azurerm_mssql_database" "sql_database" {
  name         = "sqldb-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
  server_id    = var.sql_server_id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name
  tags         = var.tags
}