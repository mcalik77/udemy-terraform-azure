resource "azurerm_network_security_group" "test_nsg" {
  name                = join("", [var.resource_prefix, "-nsg"])
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name 
}

resource "azurerm_network_security_rule" "test_nsg_rule_rdp" {
  name                        = "RDP Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test_rg.name
  network_security_group_name = azurerm_network_security_group.test_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "test_nsg_assoc" {
  subnet_id                 = azurerm_subnet.test_subnet.id
  network_security_group_id = azurerm_network_security_group.test_nsg.id
}