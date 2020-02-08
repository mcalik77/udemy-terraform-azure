resource "azurerm_virtual_network" "test_vnet" {
  name                = join("", [var.resource_prefix, "-vnet"])
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  address_space       = [var.vnet_adress]
}

resource "azurerm_subnet" "test_subnet" {
  name                 = join("", [var.resource_prefix, "-subnet"])
  resource_group_name  = azurerm_resource_group.test_rg.name
  virtual_network_name = azurerm_virtual_network.test_vnet.name
  address_prefix       = var.subnet_prefix
}

resource "azurerm_public_ip" "test_public_ip" {
  name = join(
    "",
    [
      var.resource_prefix,
      format("%02d", count.index),
      "-public-ip"
    ]
  )

  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  allocation_method   = "Dynamic"
  count               = var.vm_count
}

resource "azurerm_network_interface" "test_nic" {
  name = join(
    "", 
    [
      var.resource_prefix,
      format("%02d", count.index),
      "-nic"
    ]
  )

  location                  = azurerm_resource_group.test_rg.location
  resource_group_name       = azurerm_resource_group.test_rg.name
  count                     = var.vm_count

  ip_configuration {
    name = join(
      "", 
      [
        var.resource_prefix,
        format("%02d", count.index),
        "-ip"
      ]
    )

    subnet_id                     = azurerm_subnet.test_subnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.test_public_ip.*.id[count.index]
  }
}