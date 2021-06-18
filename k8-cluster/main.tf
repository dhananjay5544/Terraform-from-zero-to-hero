terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name = var.resourceGroupName
  location = var.location
}

resource "azurerm_kubernetes_cluster" "main" {
  name = "internal-aks"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix = "internalaks"

  default_node_pool {
    name = "default"
    node_count = 2
    vm_size = "Standard_B2s"
  }
  
  addon_profile {
    http_application_routing {
      enabled = true
    }
    kube_dashboard {
      enabled = true
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
      Environment = "Dev"
  }
}

output "client-certificate" {
  value = azurerm_kubernetes_cluster.main.kube_config.0.client_certificate
}

output "kube-config" {
  value = azurerm_kubernetes_cluster.main.kube_config_raw
}