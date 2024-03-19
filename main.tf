# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# 리소스 그룹 생성
module "resource_group" {
  source   = "./modules/resource_group"
  location = var.location
  name     = var.rg-name
}

# Virtual Network / Subnet 생성
module "network" {
  source              = "./modules/vnet"
  name                = var.vnet-name
  location            = var.location
  resource_group_name = var.rg-name
}

# Virtual Machine / Public IP / NIC생성
module "frontendvm" {
  source              = "./modules/virtual_machine"
  name                = var.vnet-name
  location            = var.location
  resource_group_name = var.rg-name
  subnet_id           = module.network.subnet1
}

# Virtual Machine / Public IP / NIC생성
module "nsg" {
  source              = "./modules/nsg"
  name                = var.vnet-name
  location            = var.location
  resource_group_name = var.rg-name
  subnet_id           = module.network.subnet1
}
####
