run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "verify_resource_group" {

  variables {
    environment  = "dev"
    main_project = "ma"
    sub_project  = "su"
    location     = "uksouth"
    tags = {
      environment = "dev"
      project     = "example-project"
    }
  }

  # assert that a resource group is identifiable 
  assert {
    condition     = length(azurerm_resource_group.resource_group.id) > 0
    error_message = "The resource group was not correclty created"
  }

  # assert that the resource group name is correctly constructed 
  assert {
    condition     = azurerm_resource_group.resource_group.name == "rg-ma-su-dev"
    error_message = "The resource group name did not match the expected value"
  }

  # assert that the resource group location is correct
  assert {
    condition     = azurerm_resource_group.resource_group.location == "uksouth"
    error_message = "The resource group location did not match the expected value"
  }

  # assert the correct tags have been applied to the resource group
  assert {
    condition     = azurerm_resource_group.resource_group.tags["environment"] == "dev"
    error_message = "The resource group tags did not match the expected values"
  }

  assert {
    condition     = azurerm_resource_group.resource_group.tags["project"] == "example-project"
    error_message = "The resource group tags did not match the expected values"
  }

}