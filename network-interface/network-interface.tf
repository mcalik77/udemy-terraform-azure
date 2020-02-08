resource "azurerm_network_interface" "test_nic" {
  name                = join("", [var.resource_prefix, "-nic"])
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name

  ip_configuration {
    name                          = join("", [var.resource_prefix, "-ip"])
    subnet_id                     = azurerm_subnet.test_subnet.id
    private_ip_address_allocation = "dynamic"
  }
}