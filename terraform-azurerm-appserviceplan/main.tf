# App service plan module

resource "azurerm_service_plan" "app_service_plan" {
  name                = local.name
  location            = var.location
  os_type             = var.os_type
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name

  tags                         = var.tags
  app_service_environment_id   = var.app_service_environment_id
  worker_count                 = var.worker_count
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  per_site_scaling_enabled     = var.per_site_scaling_enabled
  zone_balancing_enabled       = var.zone_balancing_enabled
}

