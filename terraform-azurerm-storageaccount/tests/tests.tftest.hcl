run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "verify_storage_account" {
  variables {
    environment              = "dev"
    main_project             = "ma"
    sub_project              = "su"
    resource_group_name      = run.setup_tests.resource_group_name
    location                 = run.setup_tests.resource_group_location
    account_tier             = "Standard"
    account_replication_type  = "LRS"
    tags = {
      environment = "dev"
      project     = "example-project"
    }
  }
  
  # Assert that the Storage Account has been created and is identifiable by its ID
  assert {
    condition     = length(azurerm_storage_account.storage_account.id) > 0
    error_message = "The Storage Account was not correctly created"
  }

  # Assert that the Storage Account name follows the expected naming convention
  assert {
    condition     = can(regex("^sa-ma-su-dev$", azurerm_storage_account.storage_account.name))
    error_message = "The Storage Account name does not follow the expected naming convention"
  }

  # Assert that the Storage Account is deployed to the correct resource group
  assert {
    condition     = azurerm_storage_account.storage_account.resource_group_name == run.setup_tests.resource_group_name
    error_message = "The Storage Account is not deployed to the correct resource group"
  }

  # Assert that the Storage Account is in the correct location
  assert {
    condition     = azurerm_storage_account.storage_account.location == run.setup_tests.resource_group_location
    error_message = "The Storage Account is not deployed in the correct location"
  }

  # Assert that the account tier is set correctly
  assert {
    condition     = azurerm_storage_account.storage_account.account_tier == "Standard"
    error_message = "The account tier for the Storage Account is incorrect"
  }

  # Assert that the replication type is set correctly
  assert {
    condition     = azurerm_storage_account.storage_account.account_replication_type == "LRS"
    error_message = "The replication type for the Storage Account is incorrect"
  }

  # Assert that the Storage Account has the correct tags
  assert {
    condition     = azurerm_storage_account.storage_account.tags["environment"] == "dev"
    error_message = "The 'environment' tag for the Storage Account is incorrect"
  }

  assert {
    condition     = azurerm_storage_account.storage_account.tags["project"] == "example-project"
    error_message = "The 'project' tag for the Storage Account is incorrect"
  }
}
