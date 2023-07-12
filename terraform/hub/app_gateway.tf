resource "azurerm_public_ip" "agw_pip" {
  name                = "pip-agw-${local.common_component_name}-${local.environment}-${module.azure_region.location_short}-01"
  location            = local.location
  resource_group_name = module.resource_group.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = "agw-${local.common_component_name}-${local.environment}-${module.azure_region.location_short}-01"
  location            = local.location
  resource_group_name = module.resource_group.rg_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "agw-subnet-${local.common_component_name}-01"
    subnet_id = module.subnets["agw"].subnet_id
  }

  frontend_ip_configuration {
    name                 = "fe-pip-${local.common_component_name}-01"
    public_ip_address_id = azurerm_public_ip.agw_pip.id
  }

  frontend_port {
    name = "fe-port-${local.common_component_name}-https-01"
    port = 443
  }

  ssl_certificate {
    name     = "wildcard.interjectdata.com"
    key_vault_secret_id = "https://kv-int-dns-ue2-01.vault.azure.net/secrets/wildcard-interjectdata-com/b922dc1f615a40258154f2dc7bb18661"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.mi_kv_dns.id]
  }

  # User defined rules

  dynamic "backend_address_pool" {
    for_each = local.agw_rules
    content {
      name = "be-pool-${backend_address_pool.value.sub_environment}-${backend_address_pool.value.application}-01"
    }
  }

  backend_http_settings {
    name                                = "be-setting-${local.common_component_name}-https-01"
    cookie_based_affinity               = "Disabled"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 60
    pick_host_name_from_backend_address = true
  }

  dynamic "http_listener" {
    for_each = local.agw_rules
    content {
      name                           = "http-listener-${http_listener.value.sub_environment}-${http_listener.value.application}-https-01"
      frontend_ip_configuration_name = "fe-pip-${local.common_component_name}-01"
      frontend_port_name             = "fe-port-${local.common_component_name}-https-01"
      protocol                       = "Https"
      host_name                      = http_listener.value.host_name
      ssl_certificate_name           = "wildcard.interjectdata.com"
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.agw_rules
    content {
      name                       = "rule-${request_routing_rule.value.sub_environment}-${request_routing_rule.value.application}-https-01"
      rule_type                  = "Basic"
      http_listener_name         = "http-listener-${request_routing_rule.value.sub_environment}-${request_routing_rule.value.application}-https-01"
      backend_address_pool_name  = "be-pool-${request_routing_rule.value.sub_environment}-${request_routing_rule.value.application}-01"
      backend_http_settings_name = "be-setting-${local.common_component_name}-https-01"
      #backend_http_settings_name = "be-${request_routing_rule.value.sub_environment}-${request_routing_rule.value.application}-${request_routing_rule.value.backend_protocol}-01"
      priority = request_routing_rule.value.rule_priority
    }
  }
}