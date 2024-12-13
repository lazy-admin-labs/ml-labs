output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "virtual_network_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "virtual_network_guid" {
  description = "The GUID of the virtual network"
  value       = azurerm_virtual_network.vnet.guid
}

output "virtual_network_location" {
  description = "Location of the virtual network"
  value       = azurerm_virtual_network.vnet.location
}
