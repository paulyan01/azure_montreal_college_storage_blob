#This is an Azure Montreal College Tutorial for Storage Account creation--->Storage Container name Creation--->Storage Blob Creation
resource "azurerm_resource_group" "azureresourcegroup" {
  name     = "MCIT_resource_group"
  location = "Canada Central"
}
resource "azurerm_storage_account" "example" {
  name                     = "MCIT-azrm_strg_acc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "example" {
  name                  = "MCIT_azrm_contnr"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}
