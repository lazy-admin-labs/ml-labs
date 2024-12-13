variable "virtual_network_name" {
  type        = string
  description = "Name of the virtual network"

  validation {
    condition     = length(var.virtual_network_name) >= 2 && length(var.virtual_network_name) <= 64
    error_message = "Virtual network name must be between 2 and 64 characters long"
  }
}

variable "location" {
  type        = string
  description = "Azure region where the virtual network will be created"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "address_space" {
  type        = list(string)
  description = "List of address spaces for the virtual network"

  validation {
    condition     = length(var.address_space) > 0
    error_message = "At least one address space must be provided"
  }
}

variable "dns_servers" {
  type        = list(string)
  description = "List of DNS server IP addresses"
  default     = []
}

variable "bgp_community" {
  type        = string
  description = "BGP community for the virtual network"
  default     = null
}

variable "ddos_protection_plan_id" {
  type        = string
  description = "ID of the DDoS protection plan to assign to the virtual network"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the virtual network"
  default     = {}
}
