# Provider configuration for Azure
provider "azurerm" {
  features {}
}

# Resource group where AKS will be deployed
resource "azurerm_resource_group" "aks_rg" {
  name     = "myResourceGroup"
  location = "East US"
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "myAKSCluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "myakscluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

#   addon_profile {
#     kube_dashboard {
#       enabled = true
#     }
#   }
}

# Kubernetes provider configuration
provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  username               = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.username
  password               = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
}

# # Apply Kubernetes manifests
# resource "kubernetes_manifest" "app_deployment" {
#   yaml_body = file("deployment.yaml")
# }

# resource "kubernetes_manifest" "app_service" {
#   yaml_body = file("service.yaml")
# }

# resource "kubernetes_manifest" "app_ingress" {
#   yaml_body = file("ingress.yaml")
# }

# # resource "kubernetes_manifest" "app_deploymentname" {
# #      manifest = yamldecode(file("${path.module}/deployment.yaml"))
  
# # }
# # resource "kubernetes_manifest" "service" {
# #   manifest = yamldecode(file("${path.module}/service.yaml"))
# # }

# # # resource "kubernetes_manifest" "ingress" {
# # #   manifest = yamldecode(file("${path.module}/ingress.yaml"))
# # # }

# resource "kubernetes_manifest" "example" {
#   depends_on = [kubernetes_namespace.example]
  
#   manifest = file("deployment.yaml")
# }

# resource "kubernetes_manifest" "service" {
#   depends_on = [kubernetes_manifest.example]
  
#   manifest = file("service.yaml")
# }

# resource "kubernetes_manifest" "ingress" {
#   depends_on = [kubernetes_manifest.service]
  
#   manifest = file("ingress.yaml")
# }
