variable "component_name" {
  description = "Component name for Resource Group"
  type        = string
}

variable "environment" {
  description = "Environment name for Resource Group"
  type        = string
  default     = "tst"
}

variable "location" {
  description = "Location of Resource Group"
  type        = string
  default     = "eastus2"

  validation {
    condition     = contains(["centralus", "eastus", "eastus2", "westus", "northcentralus", "southcentralus", "westcentralus", "westus2", "westus3"], var.location)
    error_message = "Resource location is not allowed. Valid values are only US locations."
  }
}

variable "tags" {
  description = "Tags to assign to Resources Group"
  type        = map(string)
  default     = {}
}
