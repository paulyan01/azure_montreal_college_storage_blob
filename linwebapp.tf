/*resource "azurerm_service_plan" "azserplan" {
  name                = "${var.prefix}-azserplan"
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_resource_group.azureresourcegroup.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "linwebapp" {
  for_each            = {for linux in local.linux_name: linux=>linux}
  name                = "${var.prefix}-linwebapp-${each.key}"
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_service_plan.azserplan.location
  service_plan_id     = azurerm_service_plan.azserplan.id

  site_config {}
}/*
