output "private_dns_zone_id" {
  value       = try(azurerm_private_dns_zone.private_dns_zone[0].id, null)
  description = "The Private DNS Zone ID."
}

output "private_dns_zone_name" {
  value       = try(azurerm_private_dns_zone.private_dns_zone[0].name, null)
  description = "The Private DNS Zone name."
}

output "private_dns_zone_number_of_record_sets" {
  value       = try(azurerm_private_dns_zone.private_dns_zone[0].number_of_record_sets, null)
  description = "The number of records in the Private DNS zone."
}

output "private_dns_zone_max_number_of_record_sets" {
  value       = try(azurerm_private_dns_zone.private_dns_zone[0].max_number_of_record_sets, null)
  description = "The maximum number of Records in the Private DNS zone."
}

output "private_dns_zone_virtual_network_link_id" {
  value       = try(azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link[0].id, null)
  description = "The ID of the Private DNS Zone Virtual Network Link."
}

output "private_dns_a_record_ids" {
  value       = try({ for name, record in azurerm_private_dns_a_record.records_a_private : name => record.id }, null)
  description = "A mapping of Private DNS A Record names to their IDs."
}

output "private_dns_a_record_fqdns" {
  value       = try({ for name, record in azurerm_private_dns_a_record.records_a_private : name => record.fqdn }, null)
  description = "A mapping of Private DNS A Record names to their FQDNs."
}

output "private_dns_cname_record_ids" {
  value       = try({ for name, record in azurerm_private_dns_cname_record.records_cname_private : name => record.id }, null)
  description = "A mapping of Private DNS CNAME Record names to their IDs."
}

output "private_dns_cname_record_fqdns" {
  value       = try({ for name, record in azurerm_private_dns_cname_record.records_cname_private : name => record.fqdn }, null)
  description = "A mapping of Private DNS CNAME Record names to their FQDNs."
}

output "dns_zone_id" {
  value       = try(azurerm_dns_zone.dns_zone[0].id, null)
  description = "The Public DNS Zone ID."
}

output "dns_zone_name" {
  value       = try(azurerm_dns_zone.dns_zone[0].name, null)
  description = "The Public DNS Zone name."
}

output "dns_zone_number_of_record_sets" {
  value       = try(azurerm_dns_zone.dns_zone[0].number_of_record_sets, null)
  description = "The number of records already in the Public DNS zone."
}

output "dns_zone_max_number_of_record_sets" {
  value       = try(azurerm_dns_zone.dns_zone[0].max_number_of_record_sets, null)
  description = "The maximum number of Records in the Public DNS zone."
}

output "dns_a_record_ids" {
  value       = try({ for name, record in azurerm_dns_a_record.records_a_public : name => record.id }, null)
  description = "A mapping of Public DNS A Record names to their IDs."
}

output "dns_a_record_fqdns" {
  value       = try({ for name, record in azurerm_dns_a_record.records_a_public : name => record.fqdn }, null)
  description = "A mapping of Public DNS A Record names to their FQDNs."
}

output "dns_cname_record_ids" {
  value       = try({ for name, record in azurerm_dns_cname_record.records_cname_public : name => record.id }, null)
  description = "A mapping of Public DNS CNAME Record names to their IDs."
}

output "dns_cname_record_fqdns" {
  value       = try({ for name, record in azurerm_dns_cname_record.records_cname_public : name => record.fqdn }, null)
  description = "A mapping of Public DNS CNAME Record names to their FQDNs."
}

output "dns_ns_record_ids" {
  value       = try({ for name, record in azurerm_dns_ns_record.records_ns_public : name => record.id }, null)
  description = "A mapping of Public DNS NS Record names to their IDs."
}

output "dns_ns_record_fqdns" {
  value       = try({ for name, record in azurerm_dns_ns_record.records_ns_public : name => record.fqdn }, null)
  description = "A mapping of Public DNS NS Record names to their FQDNs."
}
