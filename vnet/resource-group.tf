resource "azurerm_resource_group" "test_rg" {
  name     = var.rg_name
  location = var.az_region
}