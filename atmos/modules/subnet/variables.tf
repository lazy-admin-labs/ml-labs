variable "subnet_name" {
  type        = string
  description = "Name of the subnet"

  validation {
    condition     = length(var.subnet_name) >= 1 && length(var.subnet_name) <= 80
    error_message = "Subnet name must be between 1 and 80 characters long"
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "address_prefixes" {
  type        = list(string)
  description = "List of address prefixes for the subnet"
}

variable "service_endpoints" {
  type        = list(string)
  description = "List of service endpoints to enable on the subnet"
  default     = []
}

variable "private_endpoint_network_policies_enabled" {
  type        = bool
  description = "Enable or disable private endpoint network policies on the subnet"
  default     = true
}

variable "private_link_service_network_policies_enabled" {
  type        = bool
  description = "Enable or disable private link service network policies on the subnet"
  default     = true
}

variable "delegation" {
  type = object({
    name                       = string
    service_delegation_name    = string
    service_delegation_actions = list(string)
  })
  description = "Delegation configuration for the subnet"
  default     = null
}
