# locals {
#   storage_account_name = "mystorageacct${random_id.random_hex.hex}"
# }
locals {
   prefix = "st"
   storage_account_name = "${local.prefix}${var.location}${var.main_project}${var.sub_project}${var.environment}"
}