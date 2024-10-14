# DNS Zone Module
- This Folder contains a module for creating DNS related resources in Azure. The module can be used to create public and private DNS Zones and Records. Currently for Private zones SOA, A and CNAME records are supported. Public Zones support SOA, A, CNAME and NS.

# Resource Dependency

- This module requires a existing resource group. 
- Depending on the configuration you require you might addtionaly need an existing virtual network. 

# Module Usage

- This module can be used to spin up a public/private dns zone with optional records and vnet linkage (private zone only). See Test cases and for a range of usage examples.

```HCL
module "private_dns_zone" {
  source                    = "../"
  zone_type                 = var.private_zone_type
  dns_zone_name             = var.dns_zone_name
  link_private_zone_to_vnet = var.link_private_zone_to_vnet
  main_project              = var.main_project
  sub_project               = var.sub_project
  environment               = var.environment
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_id        = azurerm_virtual_network.vnet.id

  # optionally add a custom soa record
  soa_record = [{
    email         = var.soa_email    
    expire_time   = var.soa_expiry_time
    minimum_ttl   = var.soa_minimum_ttl
    refresh_time  = var.soa_refresh_time
    retry_time    = var.soa_retry_time
    ttl           = var.soa_ttl
  }]

  # optionally add a list of a records 
  a_records = [{
    name    = var.a_record_name
    ttl     = var.record_ttl
    records = var.a_record_value_list
    },
    {
      name    = var.a_record_2_name
      ttl     = var.record_ttl
      records = var.a_record_value_list
  }]

  # optionally add a list of cname records 
  cname_records = [{
    name   = var.cname_record_name
    ttl    = var.record_ttl
    record = var.cname_record_value
  }]
}
```

# Input Reference

### Reqruied

- **zone_type** - (Required) Flag for determining which type of resources will be created. Valid inputs are "public" or "private". Changing this forces resources to be destroyed and new resources of a different type to be created.
- **dns_zone_name** - (Required) domain name for DNS zone. Changing this forces a new DNS Zone to be created"
- **resource_group_name** - (Required) The name of the resource group for the DNS Zone. Changing this forces a new DNS Zone to be created
- **main_project** - (Required) custom variable. main project name. Changing this forces a new DNS Zone to be created.
- **sub_project** - (Required) custom variable. sub project name. Changing this forces a new DNS Zone to be created.
- **environment** - (Required) custom variable. This is the environment name where the DNS Zone will be created. Changing this forces a new DNS Zone to be created.

### Optional

- **link_private_zone_to_vnet** - (Optional) Supported types: [private]. Flag for enabling **private** dns zone link to existing virtual network. Deafult is false
- **virtual_network_id** - Supported types: [private]. (Optional) The ID of the virtual network for linking a **private** DNS Zone. Default is an empty string
- **soa_record** - (Optional) Supported types: [public, private]. Customize details about the root block device of the DNS Zone. Deafult is an empty list. 
- **a_records** - (Optional) Supported types: [public, private]. List of a records to be added in DNS Zone. Default is an empty list. 
- **cname_records** - (Optional) Supported types: [public, private]. List of cname records to be added in DNS Zone. Default is an empty list. 
- **ns_records** - (Optional) Supported types: [public]. List of ns records to be added in DNS Zone. Default is an empty list. 
- **private_registration_enabled** - (Optional) Supported types: [private]. Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Default is false
- **tags** - (Optional) A mapping of tags which should be assigned to the DNS Zone


# Outputs

### Private zone_type outputs 

- **private_dns_zone_id** - The Private DNS Zone ID.
- **private_dns_zone_name** - The Private DNS Zone name.
- **private_dns_zone_number_of_record_sets** - The number of records in the Private DNS zone. 
- **private_dns_zone_max_number_of_record_sets** - The maximum number of Records in the Private DNS zone.
- **private_dns_zone_virtual_network_link_id** - The ID of the Private DNS Zone Virtual Network Link.
- **private_dns_a_record_ids** - A mapping of Private DNS A Record names to their IDs.
- **private_dns_a_record_fqdns** - A mapping of Private DNS A Record names to their FQDNs.
- **private_dns_cname_record_ids** - A mapping of Private DNS CNAME Record names to their IDs.
- **private_dns_cname_record_fqdns** - A mapping of Private DNS CNAME Record names to their FQDNs.

### Public zone_type outputs

- **dns_zone_id** - The Public DNS Zone ID.
- **dns_zone_name** - The Public DNS Zone name.
- **dns_zone_number_of_record_sets** - The number of records already in the Public DNS zone.
- **dns_zone_max_number_of_record_sets** - The maximum number of Records in the Public DNS zone. 
- **dns_a_record_ids** - A mapping of Public DNS A Record names to their IDs.
- **dns_a_record_fqdns** - A mapping of Public DNS A Record names to their FQDNs.
- **dns_cname_record_ids** - A mapping of Public DNS CNAME Record names to their IDs.
- **dns_cname_record_fqdns** - A mapping of Public DNS CNAME Record names to their FQDNs.
- **dns_ns_record_ids** - A mapping of Public DNS NS Record names to their IDs.
- **dns_ns_record_fqdns** - A mapping of Public DNS NS Record names to their FQDNs.

# Test Cases

- There are 6 test cases covered in this repo. See `tests/tests.tftest.hcl`
- To run tests locally run `terraform init` and then `terraform test` in the root directory 

TODO: add more test details here

```

