variable "component_name" {
  description = "Component name for NSG"
  type        = string
}

variable "environment" {
  description = "Environment name for NSG"
  type        = string
  default     = "tst"
}

variable "location" {
  description = "Location of NSG"
  type        = string
  default     = "eastus2"

  validation {
    condition     = contains(["centralus", "eastus", "eastus2", "westus", "northcentralus", "southcentralus", "westcentralus", "westus2", "westus3"], var.location)
    error_message = "Resource location is not allowed. Valid values are only US locations."
  }
}

variable "private_dns_zone_id" {
  description = "Private DNS Zone ID for Private Endpoint"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name for Subnet"
  type        = string
}

variable "vnet_integration_subnet_id" {
  description = "Subnet ID for Vnet integration"
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "Private Endpoint Subnet ID"
  type        = string
}

variable "service_plan_id" {
  description = "Service Plan ID for App Service"
  type        = string
}

variable "tags" {
  description = "Tags to assign to Resources Group"
  type        = map(string)
  default     = {}
}
