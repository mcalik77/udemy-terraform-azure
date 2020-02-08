resource "azurerm_virtual_network" "test_vnet" {
  name                = join("", [var.resource_prefix, "-vnet"])
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  address_space       = [var.vnet_adress]
}