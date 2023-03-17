terraform {

  backend "local" {
  }
 
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.48.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}