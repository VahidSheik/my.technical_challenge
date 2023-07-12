data "azurerm_client_config" "current" {
}

data "azurerm_user_assigned_identity" "mi_kv_dns" {
  name                = "kpmg-test-mi"
  resource_group_name = "kpmg_challenge"
}