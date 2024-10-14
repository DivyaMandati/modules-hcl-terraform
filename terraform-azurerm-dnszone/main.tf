# private dns zone resources 

resource "azurerm_private_dns_zone" "private_dns_zone" {
  count               = var.zone_type == "private" ? 1 : 0
  name                = "${var.private_dns_zone_name_prefix}.${var.dns_zone_name}"
  resource_group_name = var.resource_group_name
  dynamic "soa_record" {
    for_each = length(var.soa_record) > 0 ? [for record in var.soa_record : record] : []
    content {
      email        = lookup(soa_record.value, "email", null)
      expire_time  = lookup(soa_record.value, "expire_time", null)
      minimum_ttl  = lookup(soa_record.value, "minimum_ttl", null)
      refresh_time = lookup(soa_record.value, "refresh_time", null)
      retry_time   = lookup(soa_record.value, "retry_time", null)
      ttl          = lookup(soa_record.value, "ttl", null)
    }
  }
  tags = local.private_combined_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_vnet_link" {
  count                 = var.zone_type == "private" && var.link_private_zone_to_vnet ? 1 : 0
  name                  = "${local.private_dns_zone_identifier}-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone[0].name
  registration_enabled  = var.private_registration_enabled
  virtual_network_id    = var.virtual_network_id
  tags                  = local.private_combined_tags
}

resource "azurerm_private_dns_a_record" "records_a_private" {
  depends_on          = [azurerm_private_dns_zone.private_dns_zone]
  for_each            = length(var.a_records) > 0 && var.zone_type == "private" ? { for record in var.a_records : record.name => record } : {}
  name                = lookup(each.value, "name", null)
  zone_name           = azurerm_private_dns_zone.private_dns_zone[0].name
  resource_group_name = var.resource_group_name
  ttl                 = lookup(each.value, "ttl", null)
  records             = lookup(each.value, "records", null)
  tags                = local.private_combined_tags
}

resource "azurerm_private_dns_cname_record" "records_cname_private" {
  depends_on          = [azurerm_private_dns_zone.private_dns_zone]
  for_each            = length(var.cname_records) > 0 && var.zone_type == "private" ? { for record in var.cname_records : record.name => record } : {}
  name                = lookup(each.value, "name", null)
  zone_name           = azurerm_private_dns_zone.private_dns_zone[0].name
  resource_group_name = var.resource_group_name
  ttl                 = lookup(each.value, "ttl", null)
  record              = lookup(each.value, "record", null)
  tags                = local.private_combined_tags
}

# public dns zone resources

resource "azurerm_dns_zone" "dns_zone" {
  count               = var.zone_type == "public" ? 1 : 0
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = local.public_combined_tags
  dynamic "soa_record" {
    for_each = length(var.soa_record) > 0 ? [for record in var.soa_record : record] : []
    content {
      email         = lookup(soa_record.value, "email", null)
      expire_time   = lookup(soa_record.value, "expire_time", null)
      minimum_ttl   = lookup(soa_record.value, "minimum_ttl", null)
      refresh_time  = lookup(soa_record.value, "refresh_time", null)
      retry_time    = lookup(soa_record.value, "retry_time", null)
      serial_number = lookup(soa_record.value, "serial_number", null)
      ttl           = lookup(soa_record.value, "ttl", null)
    }
  }
}

resource "azurerm_dns_a_record" "records_a_public" {
  depends_on          = [azurerm_dns_zone.dns_zone]
  for_each            = length(var.a_records) > 0 && var.zone_type == "public" ? { for record in var.a_records : record.name => record } : {}
  name                = lookup(each.value, "name", null)
  zone_name           = azurerm_dns_zone.dns_zone[0].name
  resource_group_name = var.resource_group_name
  ttl                 = lookup(each.value, "ttl", null)
  records             = lookup(each.value, "records", null)
  target_resource_id  = lookup(each.value, "target_resource_id", null)
  tags                = local.public_combined_tags
}

resource "azurerm_dns_cname_record" "records_cname_public" {
  depends_on          = [azurerm_dns_zone.dns_zone]
  for_each            = length(var.cname_records) > 0 && var.zone_type == "public" ? { for record in var.cname_records : record.name => record } : {}
  name                = lookup(each.value, "name", null)
  zone_name           = azurerm_dns_zone.dns_zone[0].name
  resource_group_name = var.resource_group_name
  ttl                 = lookup(each.value, "ttl", null)
  record              = lookup(each.value, "record", null)
  target_resource_id  = lookup(each.value, "target_resource_id", null)
  tags                = local.public_combined_tags
}

resource "azurerm_dns_ns_record" "records_ns_public" {
  depends_on          = [azurerm_dns_zone.dns_zone]
  for_each            = length(var.ns_records) > 0 && var.zone_type == "public" ? { for record in var.ns_records : record.name => record } : {}
  name                = lookup(each.value, "name", null)
  zone_name           = azurerm_dns_zone.dns_zone[0].name
  resource_group_name = var.resource_group_name
  ttl                 = lookup(each.value, "ttl", null)
  records             = lookup(each.value, "records", null)
  tags                = local.public_combined_tags
}