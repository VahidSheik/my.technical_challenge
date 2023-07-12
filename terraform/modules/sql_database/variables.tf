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

variable "sql_server_id" {
  description = "ID for SQL Server of this database"
  type        = string
}

variable "max_size_gb" {
  description = "Maximum size of Database in GB"
  type        = number
}

variable "sku_name" {
  description = "SQL Database SKU"
  type        = string
}

variable "tags" {
  description = "Tags to assign to Resources Group"
  type        = map(string)
  default     = {}
}
