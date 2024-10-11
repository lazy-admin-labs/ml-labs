variable "name" {
  type        = string
  description = "Name of the deployment"
  default     = "lazyml"
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
  default     = "djd"
}
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
variable "dsvm_subnet_address_space" {
  type        = list(string)
  description = "Address space of the DSVM subnet"
  default     = ["10.0.4.0/24"]
}

variable "bastion_subnet_address_space" {
  type        = list(string)
  description = "Address space of the bastion subnet"
  default     = ["10.0.5.0/24"]
}

variable "image_build_compute_name" {
  type        = string
  description = "Name of the compute cluster to be created and set to build docker images"
  default     = "image-builder"
}

#region DSVM Variables
variable "dsvm_name" {
  type        = string
  description = "Name of the Data Science VM"
  default     = "vmdsvm01"
}
variable "dsvm_admin_username" {
  type        = string
  description = "Admin username of the Data Science VM"
  default     = "azureadmin"
}

variable "dsvm_host_password" {
  type        = string
  description = "Password for the admin username of the Data Science VM"
  sensitive   = true
  default     = "willBeGenerated"
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
