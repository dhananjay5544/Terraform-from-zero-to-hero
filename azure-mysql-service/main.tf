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

resource "azurerm_mysql_server" "main" {
  name = "my-server-rit"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  administrator_login = "mysqladmin"
  administrator_login_password = "Test!@#$%"

  sku_name = "B_Gen5_2"
  storage_mb = 5120
  version = "8.0"

  auto_grow_enabled = true
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled = true
  ssl_enforcement_enabled = false
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

