resource "azurerm_traffic_manager_profile" "traffic_manager" {
  name = join(
    "", 
    [
      module.web_server_westus.resource_prefix,
      "-traffic-manager"
    ]
  )

  resource_group_name    = module.web_server_westus.web_server_rg_name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = module.web_server_westus.domain_name
    ttl           = 100
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager_endpoint" "traffic_manager_westus" {
  name = join(
    "", 
    [
      module.web_server_westus.resource_prefix,
      "-endpoint"
    ]
  )

  resource_group_name = azurerm_traffic_manager_profile.traffic_manager.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager.name
  target_resource_id  = module.web_server_westus.web_server_lb_public_ip_id
  type                = "azureEndpoints"
  weight              = 100
}

resource "azurerm_traffic_manager_endpoint" "traffic_manager_eastus" {
  name = join(
    "", 
    [
      module.web_server_eastus.resource_prefix,
      "-endpoint"
    ]
  )

  resource_group_name = azurerm_traffic_manager_profile.traffic_manager.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager.name
  target_resource_id  = module.web_server_eastus.web_server_lb_public_ip_id
  type                = "azureEndpoints"
  weight              = 100
}