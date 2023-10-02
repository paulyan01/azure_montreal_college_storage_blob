resource "azurerm_kubernetes_cluster" "k8scluster" {
  for_each            ={for cluster in local.cluster_name:cluster=>cluster}
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
  value     = [for cluster in azurerm_kubernetes_cluster.k8scluster: cluster.kube_config.0.client_certificate]
  sensitive = true
}

output "kube_config" {
  value = [for cluster in azurerm_kubernetes_cluster.k8scluster: cluster.kube_config_raw]

  sensitive = true
}
resource "azurerm_kubernetes_cluster_node_pool" "clusterpool" {
  for_each              = azurerm_kubernetes_cluster.k8scluster
  name                  = "${each.key}"
  kubernetes_cluster_id = each.value.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    Environment = "Production"
  }
}
