variable "allow_ports" {
  description = "List of ports which needs to be allowed on this NSG"
  type        = list(any)
  default     = []
}

variable "allow_subnets" {
  description = "List of address prefix of subnets which needs to be allowed on this NSG"
  type        = list(any)
  default     = []
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
  description = "Resource Group name for NSG"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to associate the NSG"
  type        = string
}

variable "tags" {
  description = "Tags to assign to Resources Group"
  type        = map(string)
  default     = {}
}
