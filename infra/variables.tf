#region Common
variable "name" {
  type        = string
  description = "Name of the deployment"
  default     = "lzb"
}

variable "environment" {
  type        = string
  description = "Name of the environment"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Location of the resources"
  default     = "West Europe"
}

variable "prefix" {
  type        = string
  description = "Prefix for naming"
  default     = "ai"
}
#endregion

#region Networking
variable "vnet_address_space" {
  type        = list(string)
  description = "Address space of the virtual network"
  default     = ["10.0.0.0/16"]
}

variable "training_subnet_address_space" {
  type        = list(string)
  description = "Address space of the training subnet"
  default     = ["10.0.1.0/24"]
}

variable "openai_subnet_address_space" {
  type        = list(string)
  description = "Address space of the openai subnet"
  default     = ["10.0.2.0/24"]
}

variable "ml_subnet_address_space" {
  type        = list(string)
  description = "Address space of the ML workspace subnet"
  default     = ["10.0.3.0/24"]
}

variable "dns_zone_id" {
  type = string
  description = "Azure DNSZone to use"
  default = "/subscriptions/fa626e61-2056-42b0-847a-1aad6fa3b5dd/resourceGroups/coreservices/providers/Microsoft.Network/dnszones/labs.lazyadmins.dev"
}
#endregion

#region Openai Deployments
variable "openai_deployments" {
  description = "(Optional) Specifies the deployments of the Azure OpenAI Service"
  type = list(object({
    name = string
    model = object({
      name    = string
      version = string
    })
    rai_policy_name = string
  }))
  default = [
    # {
    #   name = "openai-gpt35turbo"
    #   model = {
    #     name = "gpt-35-turbo"
    #     version = "0301"
    #   }
    #   rai_policy_name = ""
    # },
    {
      name = "openai-gpt4o"
      model = {
        name    = "gpt-4o"
        version = "2024-05-13"
      }
      rai_policy_name = ""
    }
  ]
}
#endregion
