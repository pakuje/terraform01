# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet1" {
  name                 = "frontend"
  address_prefixes     = ["10.0.0.0/24"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
resource "azurerm_subnet" "subnet2" {
  name                 = "backend"
  address_prefixes     = ["10.0.1.0/24"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}




