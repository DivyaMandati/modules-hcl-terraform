terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.3.0"
    }

  }
  required_version = "1.6.6"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test-rg" {
  name     = "test-rg"
  location = "uksouth"
}

output "resource_group_name" {
  value = azurerm_resource_group.test-rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.test-rg.location
}