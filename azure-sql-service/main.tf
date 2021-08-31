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
  subscription_id = "efec8760-1815-4f4f-9905-fa3b235f5cbe"
}

resource "azurerm_sql_server" "main" {
  name                         = "mysqlserver-mastery"
  resource_group_name          = var.resourceGroupName
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqluser"
  administrator_login_password = "Test!@#$%^"

  tags = {
    environment = "dev"
  }
}
