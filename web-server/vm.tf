resource "azurerm_virtual_machine_scale_set" "web_server_vm" {
  name                = join("", [var.resource_prefix, "-scale-set"])
  location            = azurerm_resource_group.web_server_rg.location
  resource_group_name = azurerm_resource_group.web_server_rg.name
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
    computer_name_prefix = var.server_name
    admin_username       = var.admin_username
    admin_password       = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  network_profile {
    name    = join("", [var.resource_prefix, "-network-profile"])
    primary = true

    ip_configuration {
      name                                   = var.resource_prefix
      primary                                = true
      subnet_id                              = azurerm_subnet.web_server_subnet.*.id[0]
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_server_lb_backend_pool.id]
    }
  }

  extension {
    name                 = join("", [var.resource_prefix, "-extension"])
    publisher            = "Microsoft.Compute"
    type                 = "CustomScriptExtension"
    type_handler_version = "1.9"

    settings = <<SETTINGS
    {
      "fileUris": ["https://raw.githubusercontent.com/eltimmo/learning/master/azureInstallWebServer.ps1"],
      "commandToExecute": "start powershell -ExecutionPolicy Unrestricted -File azureInstallWebServer.ps1"
    }
    SETTINGS
  }
}