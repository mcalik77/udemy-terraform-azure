resource "azurerm_resource_group" "web_server_rg" {
  name     = join("", [var.resource_prefix, "-rg"])
  location = var.server_region
}