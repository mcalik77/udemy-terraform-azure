resource "azurerm_lb" "test_lb" {
  name                = join("", [var.resource_prefix, "-lb"])
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name

  frontend_ip_configuration {
    name                 = join("", [var.resource_prefix, "-lb-frontend-ip"])
    public_ip_address_id = azurerm_public_ip.test_lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "test_lb_backend_pool" {
  name                = join("", [var.resource_prefix, "-lb-backend-pool"])
  resource_group_name = azurerm_resource_group.test_rg.name
  loadbalancer_id     = azurerm_lb.test_lb.id 
}

resource "azurerm_lb_probe" "test_lb_http_probe" {
  name                = join("", [var.resource_prefix, "-lb-http-probe"])
  resource_group_name = azurerm_resource_group.test_rg.name
  loadbalancer_id     = azurerm_lb.test_lb.id
  protocol            = "tcp"
  port                = "80"
}

resource "azurerm_lb_rule" "test_lb_http_rule" {
  name                           = join("", [var.resource_prefix, "-lb-http-rule"])
  resource_group_name            = azurerm_resource_group.test_rg.name
  loadbalancer_id                = azurerm_lb.test_lb.id
  protocol                       = "tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = join("", [var.resource_prefix, "-lb-frontend-ip"])
  probe_id                       = azurerm_lb_probe.test_lb_http_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.test_lb_backend_pool.id
}