locals{
  linux_app=[for f in fileset("${path.module}/configs", "[^_]*.yaml") : yamldecode(file("${path.module}/configs/${f}"))]
  linux_app_list = flatten([
    for app in local.linux_app : [
      for linuxapps in try(app.linux_app, []) :{
        name=linuxapps.name
        resource_group_name=linuxapps.resource_group
        location=linuxapps.location
        os_type=linuxapps.os_type
        sku_name=linuxapps.sku_name     
      }
    ]
])
}
resource "azurerm_resource_group" "azureresourcegroup" {
for_each={for rg in local.linux_app_list:"${rg.name} => rg}  
  name     = each.value.name
  location = each.value.location
}
/*
resource "azurerm_service_plan" "azserplan" {
  for_each            ={for sp in local.linux_app_list: "$sp.name"=>sp }
  name                = each.value.name
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_resource_group.azureresourcegroup.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}

resource "azurerm_linux_web_app" "linwebapp" {
  for_each            = azurerm_service_plan.azserplan
  name                = each.value.name
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_resource_group.azureresourcegroup.location
  service_plan_id     = each.value.id

  site_config {}
}
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
