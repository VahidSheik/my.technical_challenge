output "app_service_id" {
  description = "Id of deployed App Service"
  value       = azurerm_windows_web_app.app_service.id
}

output "app_service_name" {
  description = "Name of deployed App Service"
  value       = azurerm_windows_web_app.app_service.name
}
