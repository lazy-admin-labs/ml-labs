
data "azurerm_client_config" "current" {}

resource "random_pet" "prefix" {
  prefix = var.prefix
  length = 2
}

resource "random_integer" "suffix" {
  min = 0000
  max = 9999
}

resource "azurerm_resource_group" "lazyml" {
  name     = "${random_pet.prefix.id}-rg-${random_integer.suffix.id}"
  location = var.location
}

resource "azurerm_key_vault" "lazyml" {
  name                        = "${random_pet.prefix.id}-kv-${random_integer.suffix.id}"
  location                    = azurerm_resource_group.lazyml.location
  resource_group_name         = azurerm_resource_group.lazyml.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "premium"
}

resource "azurerm_key_vault_access_policy" "lazyml" {
  key_vault_id = azurerm_key_vault.lazyml.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]
}
