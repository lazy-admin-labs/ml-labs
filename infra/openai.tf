resource "azurerm_cognitive_account" "openai" {
  name                = "oai${var.prefix}${var.environment}${var.name}${random_integer.suffix.id}"
  location            = azurerm_resource_group.lazyml.location
  resource_group_name = azurerm_resource_group.lazyml.name
  kind                = "OpenAI"
  sku_name            = "S0"

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [azurerm_resource_group.lazyml, azurerm_key_vault.general_use, module.vnet]
}

resource "azurerm_cognitive_deployment" "deployment" {
  for_each = { for deployment in var.openai_deployments : deployment.name => deployment }

  name                 = each.key
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = each.value.model.name
    version = each.value.model.version
  }

  scale {
    type = "GlobalStandard"
  }
  lifecycle {
    ignore_changes = [model, scale]
  }
  depends_on = [azurerm_cognitive_account.openai]
}
