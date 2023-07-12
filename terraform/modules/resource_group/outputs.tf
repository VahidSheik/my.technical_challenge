output "rg_name" {
  description = "Name of deployed Azure Resource Group"
  value       = azurerm_resource_group.resource_group.name
}

output "rg_location" {
  description = "Location of deployed Azure Resource Group"
  value       = azurerm_resource_group.resource_group.location
}

output "rg_id" {
  description = "ID of deployed Azure Resource Group"
  value       = azurerm_resource_group.resource_group.id
}