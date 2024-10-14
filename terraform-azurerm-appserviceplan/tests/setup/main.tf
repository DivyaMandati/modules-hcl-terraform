terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.42.0"
    }
  }
  required_version = "1.6.6"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test_rg" {
  location = "uksouth"
  name     = "rg-test-local-dev"
}

output "resource_group_name" {
  value = azurerm_resource_group.test_rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.test_rg.location
}