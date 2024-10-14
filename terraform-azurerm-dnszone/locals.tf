locals {
  dns_zone_identifier = "${var.dns_zone_resource_prefix}-${var.main_project}-${var.sub_project}-${var.environment}"
  public_tags = {
    "Name" = local.dns_zone_identifier
  }
  public_combined_tags        = merge(local.public_tags, var.tags)
  private_dns_zone_identifier = "${var.private_dns_zone_resource_prefix}-${var.main_project}-${var.sub_project}-${var.environment}"
  private_tags = {
    "Name" = local.private_dns_zone_identifier
  }
  private_combined_tags = merge(local.private_tags, var.tags)
}