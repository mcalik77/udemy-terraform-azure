resource "azurerm_public_ip" "test_public_ip" {
  name                = join("", [var.resource_prefix, "-public-ip"])
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  allocation_method   = "Dynamic"
}