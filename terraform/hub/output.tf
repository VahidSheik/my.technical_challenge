output "hub_vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "app_gateway_subnet_address_prefixes" {
  value = module.subnets["agw"].subnet_address_prefixes
}

output "hub_resource_group_name" {
  value = module.resource_group.rg_name
}

output "sql_dns_name" {
  value = azurerm_private_dns_zone.sql_dns.name
}

output "app_service_dns_name" {
  value = azurerm_private_dns_zone.app_service_dns.name
}

output "app_service_dns_id" {
  value = azurerm_private_dns_zone.app_service_dns.id
}

output "sql_dns_id" {
  value = azurerm_private_dns_zone.sql_dns.id
}
