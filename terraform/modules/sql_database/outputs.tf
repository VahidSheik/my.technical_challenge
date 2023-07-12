output "sql_database_id" {
  description = "Id of deployed SQL database"
  value       = azurerm_mssql_database.sql_database.id
}

output "sql_database_name" {
  description = "Name of deployed SQL database"
  value       = azurerm_mssql_database.sql_database.name
}
