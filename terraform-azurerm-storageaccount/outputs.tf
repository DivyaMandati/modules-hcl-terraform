output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.storage_account.id
}

output "blob_container_url" {
  description = "The URL of the blob container."
  value       = azurerm_storage_container.blob_container.id
}
