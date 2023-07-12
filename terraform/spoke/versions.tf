terraform {
  required_version = ">= 1.3"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.33.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.41.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "kpmg_challenge"
    storage_account_name = "kpmgvahid8745"
    container_name       = "terraform"
    key                  = "test.tfstate"
  }
  
}

provider "azurerm" {

  features {
  }
}
