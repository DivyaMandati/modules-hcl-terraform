# static

variable "dns_zone_resource_prefix" {
  type        = string
  description = "(Static) resource specific prefix for standard naming convention"
  default     = "dns-zone"
}

variable "private_dns_zone_resource_prefix" {
  type        = string
  description = "(Static) resource specific prefix for standard naming convention"
  default     = "private-dns-zone"
}

variable "private_dns_zone_name_prefix" {
  type        = string
  description = "(Static) prefix for private DNS Zone name"
  default     = "privatelink"
}
# required

variable "zone_type" {
  type        = string
  description = "(Required) Flag for determining if DNS resources will be public or private"

  validation {
    condition     = var.zone_type == "public" || var.zone_type == "private"
    error_message = "Invalid zone_type. zone_type should be either 'public' or 'private'"
  }
}

variable "dns_zone_name" {
  type        = string
  description = "(Required) domain name for DNS zone. Changing this forces a new DNS Zone to be created"
}

variable "main_project" {
  type        = string
  description = "(Required) custom variable. main project name. Changing this forces a new DNS Zone to be created."
}

variable "sub_project" {
  type        = string
  description = "(Required) custom variable. sub project name. Changing this forces a new DNS Zone to be created."
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group for the DNS Zone. Changing this forces a new DNS Zone to be created"
  type        = string
}

variable "environment" {
  type        = string
  description = "(Required) custom variable. This is the environment name where the DNS Zone will be created. Changing this forces a new DNS Zone to be created."

  validation {
    condition     = var.environment == "dev" || var.environment == "npa" || var.environment == "stg" || var.environment == "prod"
    error_message = "Invalid environment name. Should be one of these - dev, npa, prod, stg"
  }
}

# optional

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to the DNS Zone"
  default     = {}
}

variable "soa_record" {
  type = list(object({
    email         = string
    expire_time   = number
    minimum_ttl   = number
    refresh_time  = number
    retry_time    = number
    serial_number = optional(number, null)
    ttl           = number
  }))
  default     = []
  description = "(Optional) Customize details about the root block device of the DNS Zone."
}

variable "a_records" {
  type = list(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default     = []
  description = "(Optional) List of a records to be added in DNS Zone."
}

variable "cname_records" {
  type = list(object({
    name   = string
    ttl    = number
    record = string
  }))
  default     = []
  description = "(Optional) List of cname records to be added in DNS Zone."
}

variable "ns_records" {
  type = list(object({
    name    = string,
    ttl     = number,
    records = list(string)
  }))
  default     = []
  description = "(Optional) List of ns records to be added in DNS Zone."
}

variable "link_private_zone_to_vnet" {
  type        = bool
  description = "(Optional) Flag for enabling private dns zone link to existing virtual network"
  default     = false
}

variable "private_registration_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled?"
}

variable "virtual_network_id" {
  type        = string
  default     = ""
  description = "(Optional) The ID of the virtual network for linking a private DNS Zone"
}