variable "location" {
}

variable "resource_group_name" {
}

variable "tags" {
  description = "tags to apply to resources created by this module"
  type        = map(any)
}

variable "key_vault_soft_delete_retention_days" {
  description = "Amount of days key vault will be soft deleted for"
  type        = number
  default     = 7
}