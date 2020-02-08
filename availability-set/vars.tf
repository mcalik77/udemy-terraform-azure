# Environment variables should be used for authentication.
#
# ARM_SUBSCRIPTION_ID
# ARM_CLIENT_ID
# ARM_CLIENT_SECRET
# ARM_TENANT_ID
#
# Reference the Azure Provider documentation for more information.

variable environment {
  default = "production"
}

variable resource_prefix {
  default = "test"
}

variable az_region {
  default = "westus"
}

variable vnet_adress {
  default = "10.0.0.0/16"
}

variable subnet_prefix {
  default = "10.0.1.0/24"
}

variable admin_username {}
variable admin_password {}

variable vm_count {
  default = 2
}