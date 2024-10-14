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