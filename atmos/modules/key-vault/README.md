# Azure Key Vault Module

This module creates an Azure Key Vault with configurable access policies.

## Features

- Creates an Azure Key Vault with premium SKU
- Configures service principal access
- Supports additional access policies
- Enables disk encryption by default
- Configures soft delete with 7-day retention

## Usage

```hcl
module "key_vault" {
  source = "./modules/key-vault"

  key_vault_name              = "kv-example-001"
  location                    = "West Europe"
  resource_group_name         = "rg-example-001"
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  service_principal_object_id = data.azurerm_client_config.current.object_id

  additional_access_policies = {
    data_science = {
      object_id = "ce860f46-dab9-4f83-8b4c-0bddf74acf82"
      key_permissions = ["Get", "List"]
      secret_permissions = ["Get", "List"]
    }
  }

  tags = {
    environment = "production"
    managed_by  = "terraform"
  }
}
```

## Required Providers

This module requires the Azure provider to be configured.

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| key_vault_name | Name of the Key Vault | string | yes |
| location | Azure region where the Key Vault will be created | string | yes |
| resource_group_name | Name of the resource group | string | yes |
| tenant_id | Azure AD tenant ID | string | yes |
| service_principal_object_id | Object ID of the service principal | string | yes |
| additional_access_policies | Additional access policies | map(object) | no |
| tags | Resource tags | map(string) | no |

## Outputs

| Name | Description |
|------|-------------|
| key_vault_id | The ID of the Key Vault |
| key_vault_uri | The URI of the Key Vault |
| key_vault_name | The name of the Key Vault |
