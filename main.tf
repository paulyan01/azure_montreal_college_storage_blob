#This is an Azure Montreal College Tutorial for Storage Account creation--->Storage Container name Creation--->Storage Blob Creation
locals{ 
  storage_name= ["north","south","east","west"]
#  clusters_name= ["paul","saj","jade","douglas","emannuel","olarewaju","oladipupo"]
  clusters_name= ["earth","wind","fire","water","heart"]
  appgt_name= ["batman","robin","redhood","nightwing","batgirl"]
  vm_name= ["bread","lettuce","tomato","bacon","mayonaise"]
  linux_name= ["red","blue","yellow","black","pink"]
#  cluster_names=["mcitk8s","mcitk8s2","mcitk8s3","mcitk8s4"]
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
  name     = "MCIT_resource_group"
  location = "Canada Central"
}
resource "azurerm_storage_account" "azurestorageaccount" {
  name                     = "${var.prefix}storageaccount"
  resource_group_name      = azurerm_resource_group.azureresourcegroup.name
  location                 = azurerm_resource_group.azureresourcegroup.location
  account_tier             = var.account_tier
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "azurestoragecontainer" {
  name                  = "mcitcontent"
  storage_account_name  = azurerm_storage_account.azurestorageaccount.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "azurestorageblob" {
  for_each               = {for blob in local.storage_name:blob=>blob}
  name                   = "${var.prefix}my-awesome-content.zip-${each.key}"
  storage_account_name   = azurerm_storage_account.azurestorageaccount.name
  storage_container_name = azurerm_storage_container.azurestoragecontainer.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}
