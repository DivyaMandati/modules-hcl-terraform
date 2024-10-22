<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-storage-account

## Introduction
- This Terraform module facilitates the creation of an Azure Storage Account with standardized configurations.
- The module allows the user to define key parameters for the Storage Account, making it easier to manage and maintain.
- It supports specifying key attributes such as replication, access tier, and storage account type, ensuring that resources are deployed as per project requirements.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.42.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.42.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Storage Account should be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Storage Account will be created. | `string` | n/a | yes |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | (Required) The performance tier of the Storage Account. Options are `Standard` or `Premium`. | `string` | `"Standard"` | no |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | (Required) The replication type of the Storage Account. Options include `LRS`, `GRS`, `RAGRS`, and `ZRS`. | `string` | `"LRS"` | no |
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | (Optional) The access tier for the storage account. Options are `Hot` or `Cool`. | `string` | `"Hot"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the Storage Account. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Account. |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The primary Blob service endpoint of the Storage Account. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Storage Account. |

## Tests

- This module includes automated tests to validate its functionality.
- To run the tests, initialize Terraform using `terraform init`, then execute `terraform test` in the root directory.
- Additional test scenarios will be updated here as required.

<!-- END_TF_DOCS -->
