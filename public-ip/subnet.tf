resource "azurerm_subnet" "test_subnet" {
  name                 = join("", [var.resource_prefix, "-subnet"])
  resource_group_name  = azurerm_resource_group.test_rg.name
  virtual_network_name = azurerm_virtual_network.test_vnet.name
  address_prefix       = var.subnet_prefix
}