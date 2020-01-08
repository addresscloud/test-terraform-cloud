variable "profile" {
}

variable "region" {
}

terraform {
  backend "remote" {
  hostname = "app.terraform.io"
  organization = "Addresscloud"
  workspaces {
      name = "hello-world-terraform"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

module "hello-world" {
  source           = "../../../modules/services/lambda"
}