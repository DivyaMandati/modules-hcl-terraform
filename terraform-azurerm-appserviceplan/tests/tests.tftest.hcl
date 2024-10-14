run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "test_linux_app_service_plan" {

  variables {
    main_project        = "test"
    sub_project         = "linux"
    environment         = "dev"
    os_type             = "Linux"
    location            = run.setup_tests.resource_group_location
    resource_group_name = run.setup_tests.resource_group_name
    sku_name            = "B1"
  }

  # assert that a resource group is identifiable 
  assert {
    condition     = length(azurerm_service_plan.app_service_plan.id) > 0
    error_message = "The linux app service plan was not correclty created"
  }

  # assert that the name is correctly constructed 
  assert {
    condition     = azurerm_service_plan.app_service_plan.name == "asp-test-linux-dev"
    error_message = "The linux app service plan name did not match the expected value"
  }

  # assert that the os type is correct
  assert {
    condition     = azurerm_service_plan.app_service_plan.os_type == "Linux"
    error_message = "The OS type for the linux app service plan did not match the expected value"
  }

  # assert that the location is correct 
  assert {
    condition     = azurerm_service_plan.app_service_plan.location == "uksouth"
    error_message = "The location for the linux app service plan did not match the expected value"
  }

  # assert that the app service plan is attached to the correct resource group
  assert {
    condition     = azurerm_service_plan.app_service_plan.resource_group_name == run.setup_tests.resource_group_name
    error_message = "The linux app service plan is not attached to the correct resource group"
  }
}

run "test_windows_app_service_plan" {

  variables {
    main_project        = "test"
    sub_project         = "windows"
    environment         = "dev"
    os_type             = "Windows"
    location            = run.setup_tests.resource_group_location
    resource_group_name = run.setup_tests.resource_group_name
    sku_name            = "B1"
  }

  # assert that a resource group is identifiable 
  assert {
    condition     = length(azurerm_service_plan.app_service_plan.id) > 0
    error_message = "The linux app service plan was not correclty created"
  }

  # assert that the name is correctly constructed 
  assert {
    condition     = azurerm_service_plan.app_service_plan.name == "asp-test-windows-dev"
    error_message = "The linux app service plan name did not match the expected value"
  }

  # assert that the os type is correct
  assert {
    condition     = azurerm_service_plan.app_service_plan.os_type == "Windows"
    error_message = "The OS type for the linux app service plan did not match the expected value"
  }

  # assert that the location is correct 
  assert {
    condition     = azurerm_service_plan.app_service_plan.location == "uksouth"
    error_message = "The location for the linux app service plan did not match the expected value"
  }

  # assert that the app service plan is attached to the correct resource group
  assert {
    condition     = azurerm_service_plan.app_service_plan.resource_group_name == run.setup_tests.resource_group_name
    error_message = "The linux app service plan is not attached to the correct resource group"
  }
}

