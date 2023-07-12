locals {
  environment                 = "spoke"
  common_component_name       = "kpmg"
  db_component_name           = "db"
  be_component_name           = "be"
  fe_component_name           = "fe"
  app_sku_name                = "S1"
  sql_sku_name                = "Basic"
  sql_max_size_gb             = 2
  sql_azuread_admin_username  = "Vahid"
  sql_azuread_admin_object_id = "d7efae9a-ae4b-44ec-a899-4aabaf90cd98"
  vnet_address_space          = ["172.18.0.0/24"]
  databases = {
    application_db = {
      database_initials = "app"
      sql_sku_name      = "S0"
      sql_max_size_gb   = 250
    }
  }
  location = "eastus2"
  subnets = {
    db    = "172.18.0.0/28"
    be    = "172.18.0.16/28"
    be-ob = "172.18.0.32/28"
    fe    = "172.18.0.48/28"
    fe-ob = "172.18.0.64/28"
  }
  tags = {
    Environment = "Spoke"
    Component   = local.common_component_name
  }
}