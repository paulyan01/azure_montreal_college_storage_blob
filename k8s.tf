resource "azurerm_kubernetes_cluster" "k8scluster" {
  for_each            ={for cluster in local.clusters_name:cluster=>cluster}
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
  value     = [for paul in azurerm_kubernetes_cluster.k8scluster: paul.kube_config.0.client_certificate]
  sensitive = true
}

output "kube_config" {
  value = [for paul in azurerm_kubernetes_cluster.k8scluster: paul.kube_config_raw]

  sensitive = true
}
