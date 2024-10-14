run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "verify_nsg_no_rules" {

  variables {
    target_name         = "test-case-1"
    resource_group_name = run.setup_tests.resource_group_name
    location            = run.setup_tests.resource_group_location
  }

  // positive assertions

  assert {
    condition     = length(azurerm_network_security_group.nsg.id) > 0
    error_message = "The network security group should be identifiable."
  }

  assert {
    condition     = azurerm_network_security_group.nsg.name == "test-case-1-nsg"
    error_message = "The network security group name is incorrect."
  }

  assert {
    condition     = azurerm_network_security_group.nsg.resource_group_name == run.setup_tests.resource_group_name
    error_message = "The network security group resource group is incorrect."
  }

  // negative assertions

  assert {
    condition     = length(azurerm_network_security_rule.inbounds) == 0
    error_message = "The network security group should have no inbound rules."
  }

  assert {
    condition     = length(azurerm_network_security_rule.outbounds) == 0
    error_message = "The network security group should have no outbound rules."
  }

}

run "verify_nsg_rules" {

  variables {
    target_name         = "test-case-2"
    resource_group_name = run.setup_tests.resource_group_name
    location            = run.setup_tests.resource_group_location

    inbound_rules = [{
      name                         = "inbound-rule-1"
      priority                     = 100
      access                       = "Allow"
      protocol                     = "Tcp"
      source_address_prefix        = "10.0.1.0/24"
      source_port_ranges           = ["80", "443"]
      destination_port_range       = "3389"
      destination_address_prefixes = ["10.0.2.0/25", "10.0.2.128/25"]
      description                  = "This is a rule."
      }, {
      name                         = "inbound-rule-2"
      priority                     = 200
      access                       = "Deny"
      protocol                     = "Udp"
      source_address_prefix        = "10.0.1.0/24"
      source_port_range            = "*"
      destination_address_prefixes = ["10.0.2.0/25", "10.0.2.128/25"]
      destination_port_range       = "443"
      }, {
      name                       = "inbound-rule-3"
      priority                   = 300
      access                     = "Deny"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }]

    outbound_rules = [{
      name                         = "outbound-rule-1"
      priority                     = 100
      access                       = "Deny"
      protocol                     = "Tcp"
      source_address_prefix        = "10.0.1.0/24"
      source_port_ranges           = ["80", "443"]
      destination_port_range       = "3389"
      destination_address_prefixes = ["10.0.2.0/25", "10.0.2.128/25"]
      description                  = "This is a rule."
      }, {
      name                         = "outbound-rule-2"
      priority                     = 200
      access                       = "Allow"
      protocol                     = "Udp"
      source_port_range            = "*"
      source_address_prefix        = "10.0.1.0/24"
      destination_address_prefixes = ["10.0.2.0/25", "10.0.2.128/25"]
      destination_port_range       = "443"
      }, {
      name                       = "outbound-rule-3"
      priority                   = 300
      access                     = "Deny"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }]
  }

  // positive assertions

  assert {
    condition     = length(azurerm_network_security_group.nsg.id) > 0
    error_message = "The network security group should be identifiable."
  }

  assert {
    condition     = azurerm_network_security_group.nsg.name == "test-case-2-nsg"
    error_message = "The network security group name is incorrect."
  }

  assert {
    condition     = azurerm_network_security_group.nsg.resource_group_name == run.setup_tests.resource_group_name
    error_message = "The network security group resource group is incorrect."
  }

  assert {
    condition     = length(azurerm_network_security_rule.inbounds) == 3
    error_message = "The correct number of inbound security rules were not created."
  }

  assert {
    condition     = length(azurerm_network_security_rule.outbounds) == 3
    error_message = "The correct number of outbound security rules were not created"
  }

  // Verify inbound rules

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-1"].name == "inbound-rule-1"
    error_message = "The InboundRule1 name is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-1"].priority == 100
    error_message = "The InboundRule1 priority is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-1"].access == "Allow"
    error_message = "The InboundRule1 access setting is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-1"].protocol == "Tcp"
    error_message = "The InboundRule1 protocol is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-1"].source_address_prefix == "10.0.1.0/24"
    error_message = "The source address prefix for InboundRule1 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-1"].source_port_ranges == toset(["80", "443"])
    error_message = "The source port ranges for InboundRule1 are incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-1"].destination_port_range == "3389"
    error_message = "The destination port range for InboundRule1 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-1"].destination_address_prefixes == toset(["10.0.2.0/25", "10.0.2.128/25"])
    error_message = "The destination address prefixes for InboundRule1 are incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-1"].description == "This is a rule."
    error_message = "The description for InboundRule1 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-2"].name == "inbound-rule-2"
    error_message = "The InboundRule2 name is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-2"].priority == 200
    error_message = "The InboundRule2 priority is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-2"].access == "Deny"
    error_message = "The InboundRule2 access setting is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-2"].protocol == "Udp"
    error_message = "The InboundRule2 protocol is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-2"].source_address_prefix == "10.0.1.0/24"
    error_message = "The source address prefix for InboundRule2 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-2"].source_port_range == "*"
    error_message = "The source port range for InboundRule2 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-2"].destination_address_prefixes == toset(["10.0.2.0/25", "10.0.2.128/25"])
    error_message = "The destination address prefixes for InboundRule2 are incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-2"].destination_port_range == "443"
    error_message = "The destination port range for InboundRule2 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-3"].name == "inbound-rule-3"
    error_message = "The InboundRule3 name is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-3"].priority == 300
    error_message = "The InboundRule3 priority is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-3"].access == "Deny"
    error_message = "The InboundRule3 access setting is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-3"].protocol == "Icmp"
    error_message = "The InboundRule3 protocol is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-3"].destination_port_range == "*"
    error_message = "The destination port range for InboundRule3 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-3"].source_port_range == "*"
    error_message = "The source port range for InboundRule3 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-3"].source_address_prefix == "*"
    error_message = "The source address prefix for InboundRule3 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.inbounds["inbound-rule-3"].destination_address_prefix == "*"
    error_message = "The destination address prefix for InboundRule3 is incorrect."
  }

  // Verify outbound rules

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-1"].name == "outbound-rule-1"
    error_message = "The OutboundRule1 name is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-1"].priority == 100
    error_message = "The OutboundRule1 priority is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-1"].access == "Deny"
    error_message = "The OutboundRule1 access setting is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-1"].protocol == "Tcp"
    error_message = "The OutboundRule1 protocol is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-1"].source_address_prefix == "10.0.1.0/24"
    error_message = "The source address prefix for OutboundRule1 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-1"].source_port_ranges == toset(["80", "443"])
    error_message = "The source port ranges for OutboundRule1 are incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-1"].destination_port_range == "3389"
    error_message = "The destination port range for OutboundRule1 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-1"].destination_address_prefixes == toset(["10.0.2.0/25", "10.0.2.128/25"])
    error_message = "The destination address prefixes for OutboundRule1 are incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-1"].description == "This is a rule."
    error_message = "The description for OutboundRule1 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-2"].name == "outbound-rule-2"
    error_message = "The OutboundRule2 name is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-2"].priority == 200
    error_message = "The OutboundRule2 priority is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-2"].access == "Allow"
    error_message = "The OutboundRule2 access setting is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-2"].protocol == "Udp"
    error_message = "The OutboundRule2 protocol is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-2"].source_address_prefix == "10.0.1.0/24"
    error_message = "The source address prefix for OutboundRule2 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-2"].destination_address_prefixes == toset(["10.0.2.0/25", "10.0.2.128/25"])
    error_message = "The destination address prefixes for OutboundRule2 are incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-2"].destination_port_range == "443"
    error_message = "The destination port range for OutboundRule2 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-3"].name == "outbound-rule-3"
    error_message = "The OutboundRule3 name is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-3"].priority == 300
    error_message = "The OutboundRule3 priority is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-3"].access == "Deny"
    error_message = "The OutboundRule3 access setting is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-3"].protocol == "Icmp"
    error_message = "The OutboundRule3 protocol is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-3"].destination_port_range == "*"
    error_message = "The destination port range for OutboundRule3 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-3"].source_port_range == "*"
    error_message = "The source port range for OutboundRule3 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-3"].source_address_prefix == "*"
    error_message = "The source address prefix for OutboundRule3 is incorrect."
  }

  assert {
    condition     = azurerm_network_security_rule.outbounds["outbound-rule-3"].destination_address_prefix == "*"
    error_message = "The destination address prefix for OutboundRule3 is incorrect."
  }
}
