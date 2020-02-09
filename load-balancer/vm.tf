resource "azurerm_virtual_machine_scale_set" "test_vm" {
  name                = join("", [var.resource_prefix, "-scale-set"])
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  upgrade_policy_mode = "manual"

  sku {
    name     = "Standard_B1s"
    tier     = "Standard"
    capacity = var.vm_count
  }

  storage_profile_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core-smalldisk"
    version   = "latest"
  }

  storage_profile_os_disk {
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name_prefix = var.resource_prefix
    admin_username       = var.admin_username
    admin_password       = var.admin_password
  }

  os_profile_windows_config {}

  network_profile {
    name    = join("", [var.resource_prefix, "-network-profile"])
    primary = true

    ip_configuration {
      name                                   = var.resource_prefix
      primary                                = true
      subnet_id                              = azurerm_subnet.test_subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.test_lb_backend_pool.id]
    }
  }
}