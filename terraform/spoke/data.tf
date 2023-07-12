data "terraform_remote_state" "hub_resources" {
  backend = "azurerm"
  config = {
    resource_group_name  = "kpmg_challenge"
    storage_account_name = "kpmgvahid8745"
    container_name       = "terraform"
    key                  = "hub.tfstate"
  }
}