output "subnet_id" {
  description = "Id of deployed Subnet"
  value       = azurerm_subnet.subnet.id
}

output "subnet_name" {
  description = "Name of deployed Subnet"
  value       = azurerm_subnet.subnet.name
}

output "subnet_address_prefixes" {
  description = "CIDR list of the created subnets"
  value       = azurerm_subnet.subnet.address_prefixes
}