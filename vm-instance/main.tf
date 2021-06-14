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
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "main" {
  name = var.resourceGroupName
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name = "${var.prefix}-newtwork"
  address_space = [ "10.0.0.0/16" ]
  location = var.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name = "${var.prefix}-internal"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = [ "10.0.2.0/24" ]
}

resource "azurerm_network_interface" "main" {
  name = "${var.prefix}-nic"
  location = var.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name = "testconfiguration"
    subnet_id = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name = "my-server"
  location = var.location
  resource_group_name = azurerm_resource_group.main.name
  network_interface_ids = [ azurerm_network_interface.main.id ]
  vm_size = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name = "myosdisk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "server"
    admin_username = "devine"
    admin_password = "Borntowin$1983"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    "environment" = "dev"
  }
}
