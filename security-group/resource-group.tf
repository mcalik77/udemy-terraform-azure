resource "azurerm_resource_group" "test_rg" {
  name     = join("", [var.resource_prefix, "-rg"])
  location = var.az_region
}