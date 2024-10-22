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

resource "azurerm_resource_group" "storage-rg" {
  name     = "storage-rg"
  location = "uksouth"
}

resource "azurerm_storage_account" "storage-account" {
  name                     = "storacc${substr(md5(azurerm_resource_group.storage-rg.name), 0, 8)}"  # Ensure name is unique
  resource_group_name     = azurerm_resource_group.storage-rg.name
  location                = azurerm_resource_group.storage-rg.location
  account_tier            = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "development"
    project     = "example-project"
  }
}

output "storage_account_name" {
  value = azurerm_storage_account.storage-account.name
}

output "resource_group_name" {
  value = azurerm_resource_group.storage-rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.storage-rg.location
}

