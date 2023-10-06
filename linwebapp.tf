resource "azurerm_service_plan" "azserplan" {
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
}
resource "azurerm_service_plan" "azserplan1" {
  for_each            ={for sp in local.linux_app_list: "$sp.name"=>sp }
  name                = each.value.name
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_resource_group.azureresourcegroup.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}

resource "azurerm_linux_web_app" "linwebapp1" {
  for_each            = azurerm_service_plan.azserplan1
  name                = each.value.name
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_resource_group.azureresourcegroup.location
  service_plan_id     = each.value.id

resource "azurerm_windows_web_app" "winwebapp" {
  name                = "example"
  resource_group_name = azurerm_resource_group.azureresiurcegroup.name
  location            = azurerm_service_plan.azserplan.location
  service_plan_id     = azurerm_service_plan.azserplan.id

  site_config {}
}
