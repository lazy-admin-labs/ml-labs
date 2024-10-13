resource "azurerm_api_management" "apim" {
  name                = "apim-${var.prefix}-${var.environment}-${var.name}"
  location            = azurerm_resource_group.lazyml.location
  resource_group_name = azurerm_resource_group.lazyml.name
  publisher_name      = "LazyLabs"
  publisher_email     = "ds@lazylabs.com"
  sku_name            = "Developer_1"

  identity {
    type = "SystemAssigned"
  }

  # ... other configurations ...
}
