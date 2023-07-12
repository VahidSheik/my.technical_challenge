variable "azuread_admin_username" {
  description = "Azure AD User name for SQL Admin"
  type        = string
}

variable "azuread_admin_object_id" {
  description = "Azure AD object ID for SQL Admin"
  type        = string
}

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

variable "private_endpoint_subnet_id" {
  description = "Private Endpoint Subnet ID"
  type        = string
}

variable "tags" {
  description = "Tags to assign to Resources Group"
  type        = map(string)
  default     = {}
}
