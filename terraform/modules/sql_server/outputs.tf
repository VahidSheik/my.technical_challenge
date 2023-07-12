output "sql_server_id" {
  description = "Id of deployed SQL Server"
  value       = azurerm_mssql_server.sql_server.id
}

output "sql_server_name" {
  description = "Name of deployed SQL Server"
  value       = azurerm_mssql_server.sql_server.name
}
