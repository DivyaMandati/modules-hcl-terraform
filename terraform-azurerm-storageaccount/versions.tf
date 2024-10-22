terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.42.0"
    }
  }
  required_version = ">= 1.5.7"
}

provider "azurerm" {
  features {}
}
