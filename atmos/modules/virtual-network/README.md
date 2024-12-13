# Azure Virtual Network Module

This module creates an Azure Virtual Network with configurable settings for address spaces, DNS servers, and DDoS protection.

## Features

- Core virtual network creation with multiple address spaces
- Custom DNS server support
- Optional DDoS protection plan integration
- BGP community support
- Comprehensive tagging system

## Usage

```hcl
module "vnet" {
  source = "./modules/virtual-network"

  virtual_network_name = "vnet-example-001"
  location            = "West Europe"
  resource_group_name = "rg-example-001"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["168.63.129.16"]

  tags = {
    environment = "production"
    managed_by  = "terraform"
  }
}
```
