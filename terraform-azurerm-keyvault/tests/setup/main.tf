provider "azurerm" {
  features {
    key_vault {
      # This is required because soft_delete_enabled on the actual keyvault resource is deprecated
      purge_soft_delete_on_destroy = true
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.29.1"
    }
  }
  required_version = "1.6.6"
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

locals {
  location = "uksouth"
  tags = {
    application      = "sas-automation-tf-test-pipeline"
    service-offering = "sas-automation-tf-test-pipeline"
    project          = "sas-automation-tf-test-pipeline"
    owner            = "sas-automation-tf-test-pipeline"
    uin              = "sas-automation-tf-test-pipeline"
  }
}

resource "azurerm_resource_group" "keyvault-sas-automation-tf-test-pipeline" {
  name     = "sas-automation-test-${random_string.random.result}"
  location = local.location
  tags     = local.tags
}

output "resource_group_name" {
  value = azurerm_resource_group.keyvault-sas-automation-tf-test-pipeline.name
}

output "resource_group_location" {
  value = azurerm_resource_group.keyvault-sas-automation-tf-test-pipeline.location
}

output "tags" {
  value = local.tags
}