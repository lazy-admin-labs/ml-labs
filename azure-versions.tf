provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.40.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4"
    }
    helm = {
      source = "hashicorp/helm"
    }
    random = {
      source = "hashicorp/random"
    }
    external = {
      source = "hashicorp/external"
    }
  }

  backend "azurerm" {
    resource_group_name  = "gordocore"
    storage_account_name = "corestore00"
    container_name       = "terraformstate"
    key                  = "openhack-azure.tfstate"
  }
}
