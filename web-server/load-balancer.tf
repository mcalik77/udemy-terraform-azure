resource "azurerm_lb" "web_server_lb" {
  name                = join("", [var.resource_prefix, "-lb"])
  location            = azurerm_resource_group.web_server_rg.location
  resource_group_name = azurerm_resource_group.web_server_rg.name

  frontend_ip_configuration {
    name                 = join("", [var.resource_prefix, "-lb-frontend-ip"])
    public_ip_address_id = azurerm_public_ip.web_server_lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "web_server_lb_backend_pool" {
  name                = join("", [var.resource_prefix, "-lb-backend-pool"])
  resource_group_name = azurerm_resource_group.web_server_rg.name
  loadbalancer_id     = azurerm_lb.web_server_lb.id 
}

resource "azurerm_lb_probe" "web_server_lb_http_probe" {
  name                = join("", [var.resource_prefix, "-lb-http-probe"])
  resource_group_name = azurerm_resource_group.web_server_rg.name
  loadbalancer_id     = azurerm_lb.web_server_lb.id
  protocol            = "TCP"
  port                = "80"
}

resource "azurerm_lb_rule" "web_server_lb_http_rule" {
  name                           = join("", [var.resource_prefix, "-lb-http-rule"])
  resource_group_name            = azurerm_resource_group.web_server_rg.name
  loadbalancer_id                = azurerm_lb.web_server_lb.id
  protocol                       = "TCP"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = join("", [var.resource_prefix, "-lb-frontend-ip"])
  probe_id                       = azurerm_lb_probe.web_server_lb_http_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.web_server_lb_backend_pool.id
}