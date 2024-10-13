resource "azurerm_automation_account" "automation" {
  name                = "aa-${var.prefix}-${var.environment}-certs"
  location            = azurerm_resource_group.lazyml.location
  resource_group_name = azurerm_resource_group.lazyml.name
  sku_name            = "Basic"

  identity {
    type = "SystemAssigned"
  }
}

# For DNS Zone management
resource "azurerm_role_assignment" "automation_dns_contributor" {
  scope                = var.dns_zone_id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_automation_account.automation.identity[0].principal_id
}

# For Key Vault access
resource "azurerm_role_assignment" "automation_key_vault_contributor" {
  scope                = azurerm_key_vault.ssl_certs.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = azurerm_automation_account.automation.identity[0].principal_id
}
