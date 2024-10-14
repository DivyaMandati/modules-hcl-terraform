output "app_service_plan_id" {
  description = "The ID of the created app service plan"
  value       = azurerm_service_plan.app_service_plan.id
}

output "app_service_plan_name" {
  description = "Name of the created app service plan"
  value       = azurerm_service_plan.app_service_plan.name
}