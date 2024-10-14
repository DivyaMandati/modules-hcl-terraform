data "azurerm_client_config" "current" {
}

data "azurerm_subscription" "current" {
}

resource "random_string" "id" {
  length  = 10
  special = false
  upper   = false
}

#tfsec:ignore:azure-keyvault-specify-network-acl
resource "azurerm_key_vault" "main" {
  name                            = "base-vault-${random_string.id.result}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  enabled_for_template_deployment = true
  sku_name                        = "standard"
  soft_delete_retention_days      = var.key_vault_soft_delete_retention_days
  purge_protection_enabled        = true
  tags                            = merge(var.tags, { "application" = "key-vault" })
}

resource "azurerm_management_lock" "key-vault" {
  name       = "key-vault-lockl"
  scope      = azurerm_key_vault.main.id
  lock_level = "CanNotDelete"
  notes      = "Preventing accidental deletion of this Key Vault"
}

