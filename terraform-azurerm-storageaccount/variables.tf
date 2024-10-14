# Variable for resource group name
variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

# Variable for location
variable "location" {
  description = "The Azure location where the storage account will be created."
  type        = string
}

# Variable for storage account name
variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

# Variable for account tier (Standard, Premium)
variable "account_tier" {
  description = "The performance tier of the storage account."
  type        = string
}

# Variable for replication type (LRS, GRS, RA-GRS, etc.)
variable "account_replication_type" {
  description = "The replication type of the storage account."
  type        = string
}

# Variable for blob container name
variable "container_name" {
  description = "The name of the blob container."
  type        = string
}

# Variable for blob container access type
variable "container_access_type" {
  description = "The access level of the blob container (private, blob, or container)."
  type        = string
  default     = "private"
}

# Variable for tags
variable "tags" {
  description = "Tags to apply to the resources."
  type        = map(string)
}
