provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "k8s" {
  name     = "k8sResourceGroup"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "myAKSCluster"
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = "k8s"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_admin_config_raw
  sensitive = true
}
