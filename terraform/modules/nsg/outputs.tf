output "nsg_id" {
  description = "Id of deployed NSG"
  value       = azurerm_network_security_group.nsg.id
}

output "nsg_name" {
  description = "Name of deployed NSG"
  value       = azurerm_network_security_group.nsg.name
}