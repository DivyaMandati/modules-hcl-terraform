# static

variable "resource_prefix" {
  type        = string
  description = "(Static) resource specific prefix for standard naming convention"
  default     = "asp"
}

# required 

variable "environment" {
  type        = string
  description = "(Required) custom variable. This is the environment name where the app service plan will be created. Changing this forces a new Service Plan to be created."

  validation {
    condition     = var.environment == "dev" || var.environment == "npa" || var.environment == "stg" || var.environment == "prod"
    error_message = "Invalid environment name. Should be one of these - dev, npa, prod, stg"
  }
}

variable "main_project" {
  type        = string
  description = "(Required) custom variable. main project name. Changing this forces a new Service Plan to be created."
}

variable "sub_project" {
  type        = string
  description = "(Required) custom variable. sub project name. Changing this forces a new Service Plan to be created."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the App service plan should exist. Should be the same as the resource group. Changing this forces a new app service plan to be created"
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group for the app service plan. Changing this forces a new app service plan to be created"
  type        = string
}

variable "os_type" {
  description = "(Required) The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `WindowsContainer`. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = try(contains(["Windows", "Linux", "WindowsContainer"], var.os_type), true)
    error_message = "Invalid os_type. Possible values are `Windows`, `Linux`, and `WindowsContainer`."
  }
}

variable "sku_name" {
  description = "(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, Y1, EP1, EP2, EP3, WS1, WS2, and WS3. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = try(contains(["B1", "B2", "B3", "D1", "F1", "FREE", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "P1v2", "P2v2", "P3v2", "P0v3", "P1v3", "P2v3", "P3v3", "P1mv3", "P2mv3", "P3mv3", "P4mv3", "P5mv3", "S1", "S2", "S3", "SHARED", "Y1", "EP1", "EP2", "EP3", "WS1", "WS2", "WS3"], var.sku_name), true)
    error_message = "Invalid sku_name. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3,P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, Y1, EP1, EP2, EP3, WS1, WS2, and WS3."
  }
}

# optional 

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to the App service plan"
  default     = null
}

variable "app_service_environment_id" {
  description = "(Optional) The ID of the App Service Environment to create this Service Plan in. Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3"
  type        = string
  default     = null
}

variable "worker_count" {
  description = "(Optional) The number of Workers (instances) to be allocated."
  type        = number
  default     = 1
}

variable "maximum_elastic_worker_count" {
  description = "(Optional) The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU."
  type        = number
  default     = null
}

variable "per_site_scaling_enabled" {
  description = "(Optional) Should Per Site Scaling be enabled."
  type        = bool
  default     = false
}

variable "zone_balancing_enabled" {
  description = "(Optional) Should the Service Plan balance across Availability Zones in the region."
  type        = bool
  default     = false
}