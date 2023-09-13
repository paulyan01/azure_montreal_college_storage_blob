#This is an Azure Montreal College Tutorial for Storage Account creation--->Storage Container name Creation--->Storage Blob Creation
resource "azurerm_resource_group" "azureresourcegroup" {
  name     = "MCIT_resource_group"
  location = "Canada Central"
}
#resource "azurerm_storage_account" "storage_account" {
  name                     = "MCIT-azrm_strg_acc"
  resource_group_name      = app_grp
  location                 = Canada Central
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "storage_container" {
  name                  = "MCIT_azrm_contnr"
  storage_account_name  = MCIT-azrm_strg_acc
  container_access_type = "private"
}
resource "azurerm_storage_blob" "storage_blob" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = MCIT-azrm_strg_acc
  storage_container_name = MCIT_azrm_contnr
  type                   = "Block"
  source                 = "some-local-file.zip"
}#
