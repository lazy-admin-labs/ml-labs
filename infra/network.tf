module "vnet" {
  source  = "Azure/subnets/azurerm"
  version = "1.0.0"

  resource_group_name = azurerm_resource_group.lazyml.name
  subnets = {
    training = {
      address_prefixes  = var.training_subnet_address_space
      service_endpoints = ["Microsoft.CognitiveServices"]
    }
    ml = {
      address_prefixes  = var.ml_subnet_address_space
      service_endpoints = ["Microsoft.CognitiveServices"]
    }
    openai = {
      address_prefixes  = var.openai_subnet_address_space
      service_endpoints = ["Microsoft.CognitiveServices"]
    }
  }
  virtual_network_address_space = var.vnet_address_space
  virtual_network_location      = var.location
  virtual_network_name          = "vnet${var.prefix}${random_integer.suffix.id}"
}
