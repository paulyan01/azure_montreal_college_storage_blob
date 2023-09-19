#This is an Azure Montreal College Tutorial for Storage Account creation--->Storage Container name Creation--->Storage Blob Creation
locals{ 
  cluster_names=["mcitk8s","mcitk8s2","mcitk8s3","mcitk8s4"]
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
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.azurestorageaccount.name
  storage_container_name = azurerm_storage_container.azurestoragecontainer.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}
resource "azurerm_kubernetes_cluster" "k8scluster" {
  for_each            ={for cluster in local.cluster_names:cluster=>cluster}
  name                = "${var.prefix}cluster-${each.key}"
  location            = azurerm_resource_group.azureresourcegroup.location
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8scluster[each.key].kube_config.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8scluster[each.key].kube_config_raw

  sensitive = true
}
