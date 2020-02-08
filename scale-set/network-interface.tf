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