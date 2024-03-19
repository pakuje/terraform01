

resource "azurerm_public_ip" "pip-vm-frontend" {
  count               = 2
  name                = "pip-vm-frontend-0${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_network_interface" "nic-vm-frontend" {
  count               = 2
  name                = "nic-vm-frontend-0${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "nic-vm-frontend-0${count.index + 1}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-vm-frontend[count.index].id
  }
}

resource "azurerm_windows_virtual_machine" "vm-frontend" {
  count               = 2
  name                = "vm-frontend-0${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_b1s"
  admin_username      = "pkj"
  admin_password      = "!234qwerasdf"
  zone                = count.index + 1
  # patch_mode          = "AutomaticByPlatform"
  network_interface_ids = [
    azurerm_network_interface.nic-vm-frontend[count.index].id
  ]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    name                 = "disk-vm-frontend-0${count.index + 1}"
    #disk_size_gb         = tonumber(each.value.os_disk_size_gb) < 127 ? "127" : each.value.os_disk_size_gb
  }
}

