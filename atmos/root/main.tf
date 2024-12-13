module "key_vault" {
  source = "../../modules/key-vault"

  key_vault_name              = "kv${var.prefix}${random_integer.suffix.id}"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.lazyml.name
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
    environment = var.environment
    managed_by  = "terraform"
  }
}
