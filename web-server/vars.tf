# Environment variables should be used for authentication.
#
# ARM_SUBSCRIPTION_ID
# ARM_CLIENT_ID
# ARM_CLIENT_SECRET
# ARM_TENANT_ID
#
# Reference the Azure Provider documentation for more information.

variable resource_prefix {
  default = "web-server"
}

variable server_region {
  default = "westus"
}

variable address_space {}
variable subnets {}
variable domain_name {}

variable server_name {}
variable vm_count {}

variable admin_username {}
variable admin_password {}