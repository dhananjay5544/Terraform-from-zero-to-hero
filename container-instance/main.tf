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

resource "azurerm_container_group" "main" {
  name = "${var.containerName}-group"
  location = var.location
  resource_group_name = azurerm_resource_group.main.name
  ip_address_type = "public"
  dns_name_label = "my-server"
  os_type = "Linux"
  container {
    name = var.containerName
    image = var.image
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 5000
      protocol = "TCP"
    }
  }

  tags = {
    environment = "dev"
  }
}
