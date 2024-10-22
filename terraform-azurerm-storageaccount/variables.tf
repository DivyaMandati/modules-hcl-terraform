variable "environment" {
  type        = string
  description = "(Required) custom variable. This is the environment name where the storage account will be created."

  validation {
    condition     = var.environment == "dev" || var.environment == "npa" || var.environment == "stg" || var.environment == "prod"
    error_message = "Invalid environment name. Should be one of these - dev, npa, prod, stg"
  }
}

variable "main_project" {
  type        = string
  description = "(Required) custom variable. main project name (lowercase letters and numbers only)"
  
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.main_project))
    error_message = "main_project must be lowercase letters and numbers only."
  }
}

variable "sub_project" {
  type        = string
  description = "(Required) custom variable. sub project name (lowercase letters and numbers only)"
  
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.sub_project))
    error_message = "sub_project must be lowercase letters and numbers only."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group where the storage account will be created."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Storage Account should exist. Changing this forces a new Storage Account to be created."
}

variable "account_tier" {
  type        = string
  description = "(Required) The tier of the storage account. Options: Standard, Premium."
}

variable "account_replication_type" {
  type        = string
  description = "(Required) The replication type for the storage account. Options: LRS, GRS, RA-GRS, etc."
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to the Storage Account."
}
