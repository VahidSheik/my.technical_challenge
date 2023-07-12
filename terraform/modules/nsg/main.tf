module "azure_region" {
  source       = "claranet/regions/azurerm"
  azure_region = var.location
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.component_name}-${var.environment}-${module.azure_region.location_short}-01"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Block-All-Traffic"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  dynamic "security_rule" {
    for_each = length(var.allow_subnets) == 0 ? [] : [1]
    content {
      name                       = "Allow-Specific-Subnet-And-Ports"
      priority                   = 4095
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = var.allow_ports
      source_address_prefixes    = var.allow_subnets
      destination_address_prefix = "*"
    }
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}