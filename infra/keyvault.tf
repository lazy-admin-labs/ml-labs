resource "azurerm_key_vault" "lazyml" {
  name                        = "kv${var.prefix}${random_integer.suffix.id}"
  location                    = azurerm_resource_group.lazyml.location
  resource_group_name         = azurerm_resource_group.lazyml.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "premium"
}

resource "azurerm_key_vault_access_policy" "spn" {
  key_vault_id = azurerm_key_vault.lazyml.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "List",
    "Create",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Purge",
    "Delete",
  ]
}

resource "azurerm_key_vault_access_policy" "ds" {
  key_vault_id = azurerm_key_vault.lazyml.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "ce860f46-dab9-4f83-8b4c-0bddf74acf82"

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]
}
