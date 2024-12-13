variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "location" {
  type        = string
  description = "Azure region where the Key Vault will be created"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID"
}

variable "service_principal_object_id" {
  type        = string
  description = "Object ID of the service principal that needs access to the Key Vault"
}

variable "additional_access_policies" {
  type = map(object({
    object_id          = string
    key_permissions    = list(string)
    secret_permissions = list(string)
  }))
  description = "Additional access policies to add to the Key Vault"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
