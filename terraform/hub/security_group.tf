resource "azuread_group" "azuread_group" {
  for_each         = local.azuread_groups
  display_name     = each.key
  security_enabled = true
}