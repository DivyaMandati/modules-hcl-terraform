# Azure App Service Plan Module
- This Folder contains a module for an Automation Centre specific implimentation of a App Service Plan. The module abstracts naming convention and provides some validation for resource arguments.

# Resource Dependency

- Azure App Service Plans are dependant on an existing azure resource group. The resource group name is a required argument of the app service plan module.

# Module Usage
```HCL
module "app_service_plan" {

  # source this repo
  depends_on = [module.resource_group]
  source = "<terraform_modules_repo_url>/terraform-azurerm-appserviceplan"
  
  # required arguments
  main_project                 = var.main_project
  sub_project                  = var.sub_project
  environment                  = var.environment
  os_type                      = var.os_type
  location                     = module.resource_group.outputs.location
  resource_group_name          = module.resource_group.outputs.resource_group_name
  sku_name                     = var.sku_name

  # optional arguments
  app_service_environment_id   = var.app_service_environment_id
  worker_count                 = var.worker_count
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  per_site_scaling_enabled     = var.per_site_scaling_enabled
  zone_balancing_enabled       = var.zone_balancing_enabled
  tags                         = var.tags
}
```

# Input Reference

The following arguments are supported:

- **environment** - (required) The environment that this resource will be tied to. Possible values include dev, npa, prod, stg. Changing this forces a new Service Plan to be created.

- **main_project** - (required) The Team Name or Main Project Name that this resources is being created under. Changing this forces a new Service Plan to be created.

- **sub_project** - (required) The Sub project name or project sub division that this resource is being created under. Changing this forces a new Service Plan to be created.

- **location** - (Required) The Azure Region where the Service Plan should exist. Changing this forces a new Service Plan to be created.

- **os_type** - (Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer. Changing this forces a new resource to be created.

- **resource_group_name** - (Required) The name of the Resource Group where the Service Plan should exist. Changing this forces a new Service Plan to be created. Changing this forces a new Service Plan to be created.

- **sku_name** - (Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3, and Y1. Isolated SKUs (I1, I2, I3, I1v2, I2v2, and I3v2) can only be used with App Service Environments. Elastic and Consumption SKUs (Y1, FC1, EP1, EP2, and EP3) are for use with Function Apps. Changing this forces a new Service Plan to be created.

- **app_service_environment_id** - (Optional) The ID of the App Service Environment to create this Service Plan in. Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3. Defaults to Null

- **maximum_elastic_worker_count** - (Optional) The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU. Defaults to Null

- **worker_count** - (Optional) The number of Workers (instances) to be allocated. Defaults to 1

- **per_site_scaling_enabled** - (Optional) Should Per Site Scaling be enabled. Defaults to false.

- **zone_balancing_enabled** - (Optional) Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created. Defaults to false. If this setting is set to true and the worker_count value is specified, it should be set to a multiple of the number of availability zones in the region. Please see the Azure documentation for the number of Availability Zones in your region.

- **tags** - (Optional) A mapping of tags which should be assigned to the AppService. Defaults to Null

# Outputs

- This module exposes the service plan name and service plan ID as outputs.

```
output "app_service_plan_id" {
    description = "The ID of the created app service plan"
    value = azurerm_service_plan.app_service_plan.id
}

output "app_service_plan_name" {
  description = "Name of the created app service plan"
  value = azurerm_service_plan.app_service_plan.name
}
```

# Test Cases

- There are 2 test cases covered in this repo. See `tests/tests.tftest.hcl`
- To run tests locally run `terraform init` and then `terraform test` in the root directory 

TODO: add more test details here
```

