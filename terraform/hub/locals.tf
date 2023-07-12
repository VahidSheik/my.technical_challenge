locals {
  environment           = "hub"
  common_component_name = "kpmg"
  vnet_address_space    = ["172.16.0.0/24"]
  location              = "eastus2"

  # Application Gateway Rules

  agw_rules = {
    test_portal = {
      sub_environment = "tst"
      application     = "fe"
      host_name       = "test.kpmgtest.com"
      rule_priority   = 1000
    }
    prod_portal = {
      sub_environment = "prd"
      application     = "fe"
      host_name       = "prod.kpmgtest.com"
      rule_priority   = 1001
    }
  }

  subnets = {
    agw = "172.16.0.0/27"
  }

  tags = {
    Environment = "Hub"
    Component   = local.common_component_name
  }
}