#this is the module for resource group

resource "azurerm_resource_group" "resource_group" {
  name     = local.name
  location = var.location
  tags     = var.tags
}