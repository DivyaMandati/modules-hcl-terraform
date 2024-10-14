
variable "environment" {
  type        = string
  description = "(Required) custom variable. This is the environment name where the resource group will be created."

  validation {
    condition     = var.environment == "dev" || var.environment == "npa" || var.environment == "stg" || var.environment == "prod"
    error_message = "Invalid environment name. Should be one of these - dev, npa, prod, stg"
  }

}

variable "main_project" {
  type        = string
  description = "(Required) custom variable. main project name"

}

variable "sub_project" {
  type        = string
  description = "(Required) custom variable. sub project name"

}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Resource Group should exist. changing this forces  a new Resource Group to be created"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to the Resource Group"
}