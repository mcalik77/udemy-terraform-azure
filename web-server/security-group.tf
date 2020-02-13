resource "azurerm_network_security_group" "web_server_nsg" {
  name                = join("", [var.resource_prefix, "-nsg"])
  location            = azurerm_resource_group.web_server_rg.location
  resource_group_name = azurerm_resource_group.web_server_rg.name 
}

resource "azurerm_network_security_rule" "web_server_nsg_rule_http" {
  name                        = "HTTP Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.web_server_rg.name
  network_security_group_name = azurerm_network_security_group.web_server_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "web_server_nsg_assoc" {
  subnet_id                 = azurerm_subnet.web_server_subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.web_server_nsg.id
  count                     = length(var.subnets)
}