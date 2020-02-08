resource "azurerm_virtual_network" "test_vnet" {
  name                = var.vnet_name
  location            = var.az_region
  resource_group_name = azurerm_resource_group.test_rg.name
  address_space       = [var.vnet_adress]
}