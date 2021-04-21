terraform {
  required_version = "0.13.6"
  backend "azurerm" {
    resource_group_name  = "somic"
    storage_account_name = "somicdata"
    container_name       = "tfstate"
    key                  = "demo.terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.52.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "common" {
  source              = "../../modules/common"
  resource_group_name = var.resource_group_name
  prefix              = var.prefix
  docker_image        = var.docker_image
  env                 = var.env
}
