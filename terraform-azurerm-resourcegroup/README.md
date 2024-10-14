# Introduction
- Managing resources in Azure efficiently often requires using resource group with standardized naming conventions.
- This Terraform module helps in automating the creation of Azure Resource Group with a consistent naming pattern.
- By using this module, you can ensure that your resource groups are named correctly based on the environment, project, and region.
- This module is designed to be integrated easily into your CI/CD pipelines, making it simple to manage your infrastructure as code.

# Azure Resource Group Module
- This is the terraform script to create Resource Group using modules which provides a flexible way to set its name based on specified variables.

# Folder structure 
```
├── README.md
├── main.tf
├── locals.tf
├── outputs.tf
├── variables.tf
│     
└── test
    ├── main.tf
    ├── variables.tf
    └── versions.tf

```

## Module Configuration

### `main.tf`
- Defines the resource group using the specified variables. 

```
resource "azurerm_resource_group" "resource_group"{
    name = local.name
    location = var.location
    tags = var.tags
}
```

### `variables.tf`
- Defines the variables required by the module.

```
variable "environment" {
    type = string
    description = "(Required) custom variable. This is the environment name where the resource group will be created."

validation {
    condition = var.environment== "dev" || var.environment == "npa"  || var.environment == "stg"|| var.environment == "prod"
    error_message = "Invalid environment name. Should be one of these - dev, npa, prod"
}

}

variable "main_project" {
    type = string
    description = "(Required) custom variable. main project name"
    
}

variable "sub_project" {
    type = string
    description = "(Required) custom variable. sub project name"
    
}

variable "location" {
    type = string
    description = "(Required) The Azure Region where the Resource Group should exist. changing this forces  a new Resource Group to be created"
}

variable "tags" {
    type = map(string)
    description = "(Optional) A mapping of tags which should be assigned to the Resource Group"
}
```
### `locals.tf`
- Defines local variables usede to construct the resource group name.

```
locals {
  # exmaple names on how they look, 
  # rg-sas-psu-dev,  rg-sas-psu-qa,  rg-sas-psu-stg
  # rg-sas-nrm-dev, rg-sas-nrm-stg, rg-sas-nrm-prod
  prefix = "rg"
  name   = "${local.prefix}-${var.main_project}-${var.sub_project}-${var.environment}"
}

```
### `outputs.tf`
- Outputs the resource group's ID and name

```
output "id" {
    description = "The id of the resource group"
    value = azurerm_resource_group.resource_group.id
}

output "name" {
    description = "The name of the resource group"
    value = azurerm_resource_group.resource_group.name
}
```
# Test Configuration

- There is 1 test case covered in this repo. See `tests/tests.tftest.hcl`
- To run tests locally run `terraform init` and then `terraform test` in the root directory 

TODO: add more test details here

- Place the following files in a test folder to test the module.

### `test/main.tf`
- Defines the test configuration for the module.

```
module "resource_group" {
  source       = "../"
  environment  = var.environment
  main_project = var.main_project
  sub_project  = var.sub_project
  location     = var.location
  tags         = var.tags

}
```
### `test/variables.tf
- Defines the variables for the test configuration.

```
variable "environment"    { default = "dev" }
variable "main_project"   { default = "ma" }
variable "sub_project"    { default = "su" }
variable "location"       { default = "uksouth"}
variable "tags" {
      default = {
        environment = "dev"
        project     = "example-project"
      }
}
```
### `test/versions.tf`
- Defines the provider for the test configuration.

```
provider "azurerm" {
  features {}
  skip_provider_registration = true
}
```
# Usage 
1. `Initialize Terraform` : Navigate to the test folder and run below command. This Initializes the terraform process.

```
terraform init
```
2. `Validate Terraform` : Navigate to the test folder and run below command. This validates our terraform code.

```
terraform validate
```
3. `Planning Terraform` : Navigate to the test folder and run below command. This gives a proper plan for resources to be created. 

```
terraform plan
```
4. `Apply Configuration` : Navigate to the test folder and run below command. Apply the configuration to create the resource group.

```
terraform apply
```