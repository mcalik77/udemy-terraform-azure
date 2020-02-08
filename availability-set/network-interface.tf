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
  name                = join("", [var.resource_prefix, "-public-ip"])
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "test_nic" {
  name                      = join("", [var.resource_prefix, "-nic"])
  location                  = azurerm_resource_group.test_rg.location
  resource_group_name       = azurerm_resource_group.test_rg.name
  network_security_group_id = azurerm_network_security_group.test_nsg.id

  ip_configuration {
    name                          = join("", [var.resource_prefix, "-ip"])
    subnet_id                     = azurerm_subnet.test_subnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.test_public_ip.id
  }
}