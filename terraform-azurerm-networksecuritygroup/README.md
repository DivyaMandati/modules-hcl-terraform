# Network Security Group Module
- This Folder contains a module for creating a network security group. The module supports attaching any number of inbound rules and/or outbound rules. Using this module will also enforce a standard naming convention. 

# Resource Dependency

- This module requires a existing resource group. 

# Module Usage

This module can be used to spin up a network security group with inbound and outbound rules.

```HCL
module "nsg" {
  source              = "../../"
  resource_group_name = "dev-rg"
  target_name         = "my-vnet" # name will be "my-vnet-nsg"
  location            = "uksouth"

  inbound_rules = [{
    name                       = "inbound-ssh-rule"
    priority                   = 400
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "block inbound tcp traffic on port 22"
    }, {
    name                       = "inbound-http-rule"
    priority                   = 300
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "block inbound tcp traffic on port 80"
  }]

  outbound_rules = [{
    name                       = "outbound-open-rule"
    priority                   = 100
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "allow all outbound traffic"
  }]

}
```

# Input Reference

### Required

- **target_name** - (Required) The name of the target of network security group. Nsg name will be constructed as '{target_name}-nsg'
- **resource_group_name** - (Required) The name of the resource group in which to create the network security group.

### Optional

- **location** - (Optional) The location where the network security group is created. Defaults to uk south
- **tags** - (Optional) A mapping of tags which should be assinged to the network security group.
- **inbound_rules** - (Optional) List of inbound rule objects.
- **outbound_rules** - (Optional) List of outbound rule objects.

### Rule Objects

inbound_rules and outbound_rules follow the same object spec.

```
object({
    name                         = string
    priority                     = number
    access                       = string
    protocol                     = string
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    source_port_range            = optional(string)
    source_port_ranges           = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    description                  = optional(string)
  })
```

If any inbound or outbound rules are provided via the `inbound_rules` or `outbound_rules` variables they will require the following.

- **name** - (Required) The name of the security rule. This needs to be unique across all Rules in the Network Security Group.
- **priority** - (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
- **access** - (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
- **protocol** - (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).

- **source_address_prefix** - (Optional) CIDR or source IP range or * to match any IP. This is required if source_address_prefixes is not specified.
- **source_address_prefixes** - (Optional) List of source address prefixes. This is required if source_address_prefix is not specified.

- **source_port_range** - (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
- **source_port_ranges** - (Optional) List of source ports or port ranges. This is required if source_port_range is not specified.

- **destination_address_prefix** - (Optional) CIDR or destination IP range or * to match any IP. This is required if destination_address_prefixes is not specified.
- **destination_address_prefixes** - (Optional) List of destination address prefixes. This is required if destination_address_prefix is not specified.

- **destination_port_range** - (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
- **destination_port_ranges** - (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified.

- **description** - (Optional) A description for this rule. Restricted to 140 characters.


# Outputs

- **id** - The network security group configuration ID.
- **name** - The name of the network security group.
- **inbound_rules** - A Mapping of inbound security rule names to security rule details.
- **outbound_rules** - A Mapping of outbound security rule names to security rule details.

# Test Cases

Tests can be found in `tests/testing.tftests.hcl`. To run tests executre `terraform init` and `terraform test` in the root of this module directory.

TODO: add details of assertions made in test suite on this module

