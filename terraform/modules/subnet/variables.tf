variable "address_prefix" {
  description = "Address prefix for this Subnet"
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

variable "resource_group_name" {
  description = "Resource Group name for Subnet"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network name for Subnet"
  type        = string
}