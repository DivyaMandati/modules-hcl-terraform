run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "verify_key_vault" {

  variables {
    key_vault_soft_delete_retention_days = 7
    resource_group_name                  = run.setup_tests.resource_group_name
    location                             = run.setup_tests.resource_group_location
    tags                                 = run.setup_tests.tags
  }
  
  # Assert that the Key Vault has been created and is identifiable by its ID
  assert {
    condition     = length(azurerm_key_vault.main.id) > 0
    error_message = "The Key Vault was not correctly created"
  }

  # Assert that the Key Vault name contains the base and random string part
  assert {
    condition     = can(regex("^base-vault-", azurerm_key_vault.main.name))
    error_message = "The Key Vault name does not follow the expected naming convention"
  }

  # Assert that the Key Vault is deployed to the correct resource group
  assert {
    condition     = azurerm_key_vault.main.resource_group_name == run.setup_tests.resource_group_name
    error_message = "The Key Vault is not deployed to the correct resource group"
  }

  # Assert that the Key Vault is in the correct location
  assert {
    condition     = azurerm_key_vault.main.location == run.setup_tests.resource_group_location
    error_message = "The Key Vault is not deployed in the correct location"
  }

  # Assert that the soft delete retention days are set correctly
  assert {
    condition     = azurerm_key_vault.main.soft_delete_retention_days == 7
    error_message = "The soft delete retention days for the Key Vault is incorrect"
  }

  # Assert that the Key Vault has the correct tags, including the "application" tag
  assert {
    condition     = azurerm_key_vault.main.tags["application"] == "key-vault"
    error_message = "The 'application' tag for the Key Vault is incorrect"
  }

  # Assert that the management lock is applied to the Key Vault with the correct lock level
  assert {
    condition     = azurerm_management_lock.key-vault.lock_level == "CanNotDelete"
    error_message = "The management lock for the Key Vault does not have the correct lock level"
  }

  # Assert that the management lock is associated with the correct Key Vault
  assert {
    condition     = azurerm_management_lock.key-vault.scope == azurerm_key_vault.main.id
    error_message = "The management lock is not associated with the correct Key Vault"
  }
}