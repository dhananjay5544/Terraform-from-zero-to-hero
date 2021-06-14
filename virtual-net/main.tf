terraform {
 required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "main" {
  name = var.resourceGroupName
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name = "VN1"
  address_space = [ "10.0.0.0/16" ]
  resource_group_name = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
}

