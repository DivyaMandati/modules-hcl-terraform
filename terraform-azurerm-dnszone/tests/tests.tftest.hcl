run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "verify_public_dns_zone" {

  variables {
    main_project        = "test"
    sub_project         = "basic"
    environment         = "dev"
    zone_type           = "public"
    dns_zone_name       = "test-case-1.com"
    resource_group_name = run.setup_tests.resource_group_name
  }

  // positive assertions 

  assert {
    condition     = length(azurerm_dns_zone.dns_zone) > 0
    error_message = "Public DNS zone was not created."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].name == "test-case-1.com"
    error_message = "Public DNS zone name is incorrect."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].resource_group_name == run.setup_tests.resource_group_name
    error_message = "Resource group name for the DNS zone is incorrect."
  }

  // negative assertions 

  assert {
    condition     = length(azurerm_private_dns_zone.private_dns_zone) == 0
    error_message = "Private DNS zone was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link) == 0
    error_message = "Private DNS vnet link was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_cname_record.records_cname_private) == 0
    error_message = "Private DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_a_record.records_a_private) == 0
    error_message = "Private DNS a records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_a_record.records_a_public) == 0
    error_message = "Public DNS a records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_cname_record.records_cname_public) == 0
    error_message = "Public DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_ns_record.records_ns_public) == 0
    error_message = "Public DNS ns records were created. This is not intended behaviour for this configuration."
  }


}

run "verify_public_dns_zone_with_custom_soa_record" {

  variables {
    main_project        = "test"
    sub_project         = "basic"
    environment         = "dev"
    zone_type           = "public"
    dns_zone_name       = "test-case-2.com"
    resource_group_name = run.setup_tests.resource_group_name

    soa_record = [{
      email         = "example.gmail.com"
      expire_time   = 1000
      minimum_ttl   = 100
      refresh_time  = 300
      retry_time    = 100
      ttl           = 1
      serial_number = 2000
    }]
  }

  // positive assertions 

  assert {
    condition     = length(azurerm_dns_zone.dns_zone) > 0
    error_message = "Public DNS zone was not created."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].name == "test-case-2.com"
    error_message = "Public DNS zone name is incorrect."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].resource_group_name == run.setup_tests.resource_group_name
    error_message = "Resource group name for the DNS zone is incorrect."
  }

  // positive assertions - soa record

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].soa_record[0].email == "example.gmail.com"
    error_message = "SOA record email is incorrect."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].soa_record[0].expire_time == 1000
    error_message = "SOA record expire_time is incorrect."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].soa_record[0].minimum_ttl == 100
    error_message = "SOA record minimum_ttl is incorrect."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].soa_record[0].refresh_time == 300
    error_message = "SOA record refresh_time is incorrect."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].soa_record[0].retry_time == 100
    error_message = "SOA record retry_time is incorrect."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].soa_record[0].ttl == 1
    error_message = "SOA record TTL is incorrect."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].soa_record[0].serial_number == 2000
    error_message = "SOA record serial_number is incorrect."
  }

  // negative assertions 

  assert {
    condition     = length(azurerm_private_dns_zone.private_dns_zone) == 0
    error_message = "Private DNS zone was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link) == 0
    error_message = "Private DNS vnet link was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_cname_record.records_cname_private) == 0
    error_message = "Private DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_a_record.records_a_private) == 0
    error_message = "Private DNS a records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_a_record.records_a_public) == 0
    error_message = "Public DNS a records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_cname_record.records_cname_public) == 0
    error_message = "Public DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_ns_record.records_ns_public) == 0
    error_message = "Public DNS ns records were created. This is not intended behaviour for this configuration."
  }

}

run "verify_public_dns_zone_with_records" {

  variables {
    main_project        = "test"
    sub_project         = "basic"
    environment         = "dev"
    zone_type           = "public"
    dns_zone_name       = "test-case-3.com"
    resource_group_name = run.setup_tests.resource_group_name

    a_records = [{
      name    = "a_record_test_1"
      ttl     = 3600
      records = ["10.0.180.17", "10.0.180.18"]
      },
      {
        name    = "a_record_test_2"
        ttl     = 1800
        records = ["10.0.180.17", "10.0.180.18"]
    }]

    cname_records = [{
      name   = "cname_record_test_1"
      ttl    = 1200
      record = "example.com"
    }]

    ns_records = [{
      name    = "ns_record_test_1"
      ttl     = 800
      records = ["ns1.example.com.", "ns2.example.com."]
    }]
  }

  // positive assertions - general 

  assert {
    condition     = length(azurerm_dns_zone.dns_zone) > 0
    error_message = "Public DNS zone was not created."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].name == "test-case-3.com"
    error_message = "Public DNS zone name is incorrect."
  }

  assert {
    condition     = azurerm_dns_zone.dns_zone[0].resource_group_name == run.setup_tests.resource_group_name
    error_message = "Resource group name for the DNS zone is incorrect."
  }

  // postive assertions - records

  // a records

  assert {
    condition     = length(azurerm_dns_a_record.records_a_public) == 2
    error_message = "Public DNS a records were not created."
  }

  assert {
    condition     = azurerm_dns_a_record.records_a_public["a_record_test_1"].name == "a_record_test_1"
    error_message = "A record 'a_record_test_1' was not created with the correct name."
  }

  assert {
    condition     = azurerm_dns_a_record.records_a_public["a_record_test_1"].ttl == 3600
    error_message = "A record 'a_record_test_1' TTL is incorrect."
  }

  assert {
    condition     = sort(azurerm_dns_a_record.records_a_public["a_record_test_1"].records) == sort(["10.0.180.17", "10.0.180.18"])
    error_message = "A record 'a_record_test_1' records are incorrect."
  }

  assert {
    condition     = azurerm_dns_a_record.records_a_public["a_record_test_2"].name == "a_record_test_2"
    error_message = "A record 'a_record_test_2' was not created with the correct name."
  }

  assert {
    condition     = azurerm_dns_a_record.records_a_public["a_record_test_2"].ttl == 1800
    error_message = "A record 'a_record_test_2' TTL is incorrect."
  }

  assert {
    condition     = sort(azurerm_dns_a_record.records_a_public["a_record_test_2"].records) == sort(["10.0.180.17", "10.0.180.18"])
    error_message = "A record 'a_record_test_2' records are incorrect."
  }

  assert {
    condition     = azurerm_dns_a_record.records_a_public["a_record_test_1"].zone_name == azurerm_dns_zone.dns_zone[0].name
    error_message = "A record 'a_record_test_1' is not pointing to the correct DNS zone."
  }

  assert {
    condition     = azurerm_dns_a_record.records_a_public["a_record_test_1"].resource_group_name == var.resource_group_name
    error_message = "A record 'a_record_test_1' is not in the correct resource group."
  }

  assert {
    condition     = azurerm_dns_a_record.records_a_public["a_record_test_2"].zone_name == azurerm_dns_zone.dns_zone[0].name
    error_message = "A record 'a_record_test_2' is not pointing to the correct DNS zone."
  }

  assert {
    condition     = azurerm_dns_a_record.records_a_public["a_record_test_2"].resource_group_name == var.resource_group_name
    error_message = "A record 'a_record_test_2' is not in the correct resource group."
  }

  // cname records

  assert {
    condition     = length(azurerm_dns_cname_record.records_cname_public) == 1
    error_message = "Public DNS cname records were not created."
  }

  assert {
    condition     = azurerm_dns_cname_record.records_cname_public["cname_record_test_1"].zone_name == azurerm_dns_zone.dns_zone[0].name
    error_message = "CNAME record 'cname_record_test_1' is not pointing to the correct DNS zone."
  }

  assert {
    condition     = azurerm_dns_cname_record.records_cname_public["cname_record_test_1"].resource_group_name == var.resource_group_name
    error_message = "CNAME record 'cname_record_test_1' is not in the correct resource group."
  }

  assert {
    condition     = azurerm_dns_cname_record.records_cname_public["cname_record_test_1"].name == "cname_record_test_1"
    error_message = "CNAME record 'cname_record_test_1' was not created with the correct name."
  }

  assert {
    condition     = azurerm_dns_cname_record.records_cname_public["cname_record_test_1"].ttl == 1200
    error_message = "CNAME record 'cname_record_test_1' TTL is incorrect."
  }

  assert {
    condition     = azurerm_dns_cname_record.records_cname_public["cname_record_test_1"].record == "example.com"
    error_message = "CNAME record 'cname_record_test_1' target is incorrect."
  }

  // ns records

  assert {
    condition     = length(azurerm_dns_ns_record.records_ns_public) == 1
    error_message = "Public DNS ns records were not created."
  }

  assert {
    condition     = azurerm_dns_ns_record.records_ns_public["ns_record_test_1"].name == "ns_record_test_1"
    error_message = "NS record 'ns_record_test_1' was not created with the correct name."
  }

  assert {
    condition     = azurerm_dns_ns_record.records_ns_public["ns_record_test_1"].ttl == 800
    error_message = "NS record 'ns_record_test_1' TTL is incorrect."
  }

  assert {
    condition     = sort(azurerm_dns_ns_record.records_ns_public["ns_record_test_1"].records) == sort(["ns1.example.com.", "ns2.example.com."])
    error_message = "NS record 'ns_record_test_1' records are incorrect."
  }

  assert {
    condition     = azurerm_dns_ns_record.records_ns_public["ns_record_test_1"].zone_name == azurerm_dns_zone.dns_zone[0].name
    error_message = "NS record 'ns_record_test_1' is not pointing to the correct DNS zone."
  }

  assert {
    condition     = azurerm_dns_ns_record.records_ns_public["ns_record_test_1"].resource_group_name == var.resource_group_name
    error_message = "NS record 'ns_record_test_1' is not in the correct resource group."
  }

  // negative assertions

  assert {
    condition     = length(azurerm_private_dns_zone.private_dns_zone) == 0
    error_message = "Private DNS zone was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link) == 0
    error_message = "Private DNS vnet link was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_cname_record.records_cname_private) == 0
    error_message = "Private DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_a_record.records_a_private) == 0
    error_message = "Private DNS a records were created. This is not intended behaviour for this configuration."
  }

}

run "verify_private_dns_zone" {

  variables {
    main_project        = "test"
    sub_project         = "basic"
    environment         = "dev"
    zone_type           = "private"
    dns_zone_name       = "test-case-4.com"
    resource_group_name = run.setup_tests.resource_group_name
  }

  // positive assertions 

  assert {
    condition     = length(azurerm_private_dns_zone.private_dns_zone) > 0
    error_message = "Private DNS zone was not created."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].name == "privatelink.test-case-4.com"
    error_message = "Private DNS zone name is incorrect."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].resource_group_name == run.setup_tests.resource_group_name
    error_message = "Resource group name for the DNS zone is incorrect."
  }

  // negative assertions 

  assert {
    condition     = length(azurerm_dns_zone.dns_zone) == 0
    error_message = "Public DNS zone was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link) == 0
    error_message = "Private DNS vnet link was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_cname_record.records_cname_private) == 0
    error_message = "Private DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_a_record.records_a_private) == 0
    error_message = "Private DNS a records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_a_record.records_a_public) == 0
    error_message = "Public DNS a records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_cname_record.records_cname_public) == 0
    error_message = "Public DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_ns_record.records_ns_public) == 0
    error_message = "Public DNS ns records were created. This is not intended behaviour for this configuration."
  }
}

run "verify_private_dns_zone_with_vnet_link" {

  variables {
    main_project              = "test"
    sub_project               = "basic"
    environment               = "dev"
    zone_type                 = "private"
    dns_zone_name             = "test-case-5.com"
    link_private_zone_to_vnet = true
    virtual_network_id        = run.setup_tests.test_vnet_1_id
    resource_group_name       = run.setup_tests.resource_group_name
  }

  // positive assertions 

  assert {
    condition     = length(azurerm_private_dns_zone.private_dns_zone) > 0
    error_message = "Private DNS zone was not created."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].name == "privatelink.test-case-5.com"
    error_message = "Private DNS zone name is incorrect."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].resource_group_name == run.setup_tests.resource_group_name
    error_message = "Resource group name for the DNS zone is incorrect."
  }

  assert {
    condition     = length(azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link) > 0
    error_message = "Private DNS vnet link was not created."
  }

  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link[0].virtual_network_id == run.setup_tests.test_vnet_1_id
    error_message = "The VNet link is not using the correct VNet ID."
  }

  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link[0].private_dns_zone_name == azurerm_private_dns_zone.private_dns_zone[0].name
    error_message = "The VNet link is not attached to the correct private DNS zone."
  }

  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link[0].resource_group_name == run.setup_tests.resource_group_name
    error_message = "The VNet link is not in the correct resource group."
  }

  // negative assertions

  assert {
    condition     = length(azurerm_dns_zone.dns_zone) == 0
    error_message = "Public DNS zone was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_cname_record.records_cname_private) == 0
    error_message = "Private DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_private_dns_a_record.records_a_private) == 0
    error_message = "Private DNS a records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_a_record.records_a_public) == 0
    error_message = "Public DNS a records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_cname_record.records_cname_public) == 0
    error_message = "Public DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_ns_record.records_ns_public) == 0
    error_message = "Public DNS ns records were created. This is not intended behaviour for this configuration."
  }

}

run "verify_private_dns_zone_with_records_and_vnet_link" {

  variables {
    main_project              = "test"
    sub_project               = "basic"
    environment               = "dev"
    zone_type                 = "private"
    dns_zone_name             = "test-case-6.com"
    link_private_zone_to_vnet = true
    virtual_network_id        = run.setup_tests.test_vnet_2_id
    resource_group_name       = run.setup_tests.resource_group_name

    soa_record = [{
      email         = "example.gmail.com"
      expire_time   = 1000
      minimum_ttl   = 100
      refresh_time  = 300
      retry_time    = 100
      ttl           = 1
    }]

    a_records = [{
      name    = "private_a_record_test_1"
      ttl     = 7200
      records = ["10.0.180.10", "10.0.180.13"]
      },
      {
        name    = "private_a_record_test_2"
        ttl     = 100
        records = ["10.0.180.10", "10.0.180.13"]
    }]

    cname_records = [{
      name   = "private_cname_record_test_1"
      ttl    = 750
      record = "private.example.com"
    }]

  }

  // positive assertions 

  assert {
    condition     = length(azurerm_private_dns_zone.private_dns_zone) > 0
    error_message = "Private DNS zone was not created."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].name == "privatelink.test-case-6.com"
    error_message = "Private DNS zone name is incorrect."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].resource_group_name == run.setup_tests.resource_group_name
    error_message = "Resource group name for the DNS zone is incorrect."
  }

  assert {
    condition     = length(azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link) > 0
    error_message = "Private DNS vnet link was not created."
  }

  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link[0].virtual_network_id == run.setup_tests.test_vnet_2_id
    error_message = "The VNet link is not using the correct VNet ID."
  }

  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link[0].private_dns_zone_name == azurerm_private_dns_zone.private_dns_zone[0].name
    error_message = "The VNet link is not attached to the correct private DNS zone."
  }

  assert {
    condition     = azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link[0].resource_group_name == run.setup_tests.resource_group_name
    error_message = "The VNet link is not in the correct resource group."
  }

  // postive assertions - records

  // a records

  assert {
    condition     = length(azurerm_private_dns_a_record.records_a_private) == 2
    error_message = "Private DNS a records were not created."
  }

  assert {
    condition     = azurerm_private_dns_a_record.records_a_private["private_a_record_test_1"].name == "private_a_record_test_1"
    error_message = "A record 'private_a_record_test_1' was not created with the correct name."
  }

  assert {
    condition     = azurerm_private_dns_a_record.records_a_private["private_a_record_test_1"].ttl == 7200
    error_message = "A record 'private_a_record_test_1' TTL is incorrect."
  }

  assert {
    condition     = sort(azurerm_private_dns_a_record.records_a_private["private_a_record_test_1"].records) == sort(["10.0.180.10", "10.0.180.13"])
    error_message = "A record 'private_a_record_test_1' records are incorrect."
  }

  assert {
    condition     = azurerm_private_dns_a_record.records_a_private["private_a_record_test_2"].name == "private_a_record_test_2"
    error_message = "A record 'private_a_record_test_2' was not created with the correct name."
  }

  assert {
    condition     = azurerm_private_dns_a_record.records_a_private["private_a_record_test_2"].ttl == 100
    error_message = "A record 'private_a_record_test_2' TTL is incorrect."
  }

  assert {
    condition     = sort(azurerm_private_dns_a_record.records_a_private["private_a_record_test_2"].records) == sort(["10.0.180.10", "10.0.180.13"])
    error_message = "A record 'private_a_record_test_2' records are incorrect."
  }

  assert {
    condition     = azurerm_private_dns_a_record.records_a_private["private_a_record_test_1"].zone_name == azurerm_private_dns_zone.private_dns_zone[0].name
    error_message = "A record 'private_a_record_test_1' is not pointing to the correct DNS zone."
  }

  assert {
    condition     = azurerm_private_dns_a_record.records_a_private["private_a_record_test_1"].resource_group_name == var.resource_group_name
    error_message = "A record 'private_a_record_test_1' is not in the correct resource group."
  }

  assert {
    condition     = azurerm_private_dns_a_record.records_a_private["private_a_record_test_2"].zone_name == azurerm_private_dns_zone.private_dns_zone[0].name
    error_message = "A record 'private_a_record_test_2' is not pointing to the correct DNS zone."
  }

  assert {
    condition     = azurerm_private_dns_a_record.records_a_private["private_a_record_test_2"].resource_group_name == var.resource_group_name
    error_message = "A record 'private_a_record_test_2' is not in the correct resource group."
  }

  // cname records

  assert {
    condition     = length(azurerm_private_dns_cname_record.records_cname_private) == 1
    error_message = "Public DNS cname records were not created."
  }

  assert {
    condition     = azurerm_private_dns_cname_record.records_cname_private["private_cname_record_test_1"].zone_name == azurerm_private_dns_zone.private_dns_zone[0].name
    error_message = "CNAME record 'private_cname_record_test_1' is not pointing to the correct DNS zone."
  }

  assert {
    condition     = azurerm_private_dns_cname_record.records_cname_private["private_cname_record_test_1"].resource_group_name == var.resource_group_name
    error_message = "CNAME record 'private_cname_record_test_1' is not in the correct resource group."
  }

  assert {
    condition     = azurerm_private_dns_cname_record.records_cname_private["private_cname_record_test_1"].name == "private_cname_record_test_1"
    error_message = "CNAME record 'private_cname_record_test_1' was not created with the correct name."
  }

  assert {
    condition     = azurerm_private_dns_cname_record.records_cname_private["private_cname_record_test_1"].ttl == 750
    error_message = "CNAME record 'private_cname_record_test_1' TTL is incorrect."
  }

  assert {
    condition     = azurerm_private_dns_cname_record.records_cname_private["private_cname_record_test_1"].record == "private.example.com"
    error_message = "CNAME record 'private_cname_record_test_1' target is incorrect."
  }

  // soa record

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].soa_record[0].email == "example.gmail.com"
    error_message = "SOA record email is incorrect."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].soa_record[0].expire_time == 1000
    error_message = "SOA record expire_time is incorrect."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].soa_record[0].minimum_ttl == 100
    error_message = "SOA record minimum_ttl is incorrect."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].soa_record[0].refresh_time == 300
    error_message = "SOA record refresh_time is incorrect."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].soa_record[0].retry_time == 100
    error_message = "SOA record retry_time is incorrect."
  }

  assert {
    condition     = azurerm_private_dns_zone.private_dns_zone[0].soa_record[0].ttl == 1
    error_message = "SOA record TTL is incorrect."
  }

  // negative assertions

  assert {
    condition     = length(azurerm_dns_zone.dns_zone) == 0
    error_message = "Public DNS zone was created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_a_record.records_a_public) == 0
    error_message = "Public DNS a records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_cname_record.records_cname_public) == 0
    error_message = "Public DNS cname records were created. This is not intended behaviour for this configuration."
  }

  assert {
    condition     = length(azurerm_dns_ns_record.records_ns_public) == 0
    error_message = "Public DNS ns records were created. This is not intended behaviour for this configuration."
  }


}
