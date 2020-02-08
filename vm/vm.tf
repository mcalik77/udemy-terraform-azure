resource "azurerm_virtual_machine" "test_vm" {
  name                  = var.resource_prefix
  resource_group_name   = azurerm_resource_group.test_rg.name
  location              = azurerm_resource_group.test_rg.location
  network_interface_ids = [azurerm_network_interface.test_nic.id]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core-smalldisk"
    version   = "latest"
  }

  storage_os_disk {
    name              = join("", [var.resource_prefix, "-os"])
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.resource_prefix
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {}
}