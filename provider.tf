provider "azurerm" {
  # Environment variables should be used for authentication.
  #
  # subscription_id = ARM_SUBSCRIPTION_ID
  # client_id       = ARM_CLIENT_ID
  # client_secret   = ARM_CLIENT_SECRET
  # tenant_id       = ARM_TENANT_ID
  #
  # Reference the Azure Provider documentation for more information.
}

variable admin_username {}
variable admin_password {}

module "web_server_westus" {
  source = "./web-server"

  server_region   = "westus"
  resource_prefix = "web-server-westus"
  address_space   = "10.0.0.0/16"
  subnets         = ["10.0.1.0/24", "10.0.2.0/24"]
  domain_name     = "thematrix"
  server_name     = "web-weus"
  vm_count        = 1
  admin_username  = var.admin_username
  admin_password  = var.admin_password
}

module "web_server_eastus" {
  source = "./web-server"

  server_region   = "eastus"
  resource_prefix = "web-server-eastus"
  address_space   = "10.0.0.0/16"
  subnets         = ["10.0.1.0/24", "10.0.2.0/24"]
  domain_name     = "thematrix"
  server_name     = "web-eaus"
  vm_count        = 1
  admin_username  = var.admin_username
  admin_password  = var.admin_password
}