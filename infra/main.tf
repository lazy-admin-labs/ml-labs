
data "azurerm_client_config" "current" {}

resource "random_integer" "suffix" {
  min = 000
  max = 999
}

resource "random_password" "dsvm_password" {
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_resource_group" "lazyml" {
  name     = "rg${var.prefix}${random_integer.suffix.id}"
  location = var.location
}

resource "azurerm_key_vault_secret" "dsvmpass" {
  name         = "dsvmpassword"
  value        = random_password.dsvm_password.result
  key_vault_id = azurerm_key_vault.lazyml.id

  depends_on = [azurerm_key_vault.lazyml, azurerm_key_vault_access_policy.spn]
}
