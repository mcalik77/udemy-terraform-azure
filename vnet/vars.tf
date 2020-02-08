# Environment variables should be used for authentication.
#
# ARM_SUBSCRIPTION_ID
# ARM_CLIENT_ID
# ARM_CLIENT_SECRET
# ARM_TENANT_ID
#
# Reference the Azure Provider documentation for more information.

variable rg_name {
  default = "test_rg"
}

variable az_region {
  default = "westus"
}

variable vnet_name {
  default = "test_vnet"
}

variable vnet_adress {
  default = "10.1.2.0/24"
}