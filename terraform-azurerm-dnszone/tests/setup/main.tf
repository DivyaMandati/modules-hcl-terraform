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

resource "azurerm_virtual_network" "test-vnet-1" {
  name                = "test-virtual-network" 
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "test-vnet-2" {
  name                = "test-virtual-network-2"
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  address_space       = ["10.0.0.0/16"]
}

output "resource_group_name" {
  value = azurerm_resource_group.test_rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.test_rg.location
}

output "test_vnet_1_id" {
  value = azurerm_virtual_network.test-vnet-1.id
}

output "test_vnet_2_id" {
  value = azurerm_virtual_network.test-vnet-2.id
}