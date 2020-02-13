resource "azurerm_virtual_network" "web_server_vnet" {
  name                = join("", [var.resource_prefix, "-vnet"])
  location            = azurerm_resource_group.web_server_rg.location
  resource_group_name = azurerm_resource_group.web_server_rg.name
  address_space       = [var.address_space]
}

resource "azurerm_subnet" "web_server_subnet" {
  name = join(
    "", 
    [
      var.resource_prefix,

      substr(
        var.subnets[count.index],
        0,
        length(var.subnets[count.index]) - 3
      ),

      "-subnet"
    ]
  )

  resource_group_name  = azurerm_resource_group.web_server_rg.name
  virtual_network_name = azurerm_virtual_network.web_server_vnet.name
  address_prefix       = var.subnets[count.index]
  count                = length(var.subnets)
}

resource "azurerm_public_ip" "web_server_lb_public_ip" {
  name                = join("", [var.resource_prefix, "-public-ip"])
  location            = azurerm_resource_group.web_server_rg.location
  resource_group_name = azurerm_resource_group.web_server_rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = var.domain_name
}