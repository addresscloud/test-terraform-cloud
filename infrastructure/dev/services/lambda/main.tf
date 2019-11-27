terraform {
  backend "remote" {
  hostname = "app.terraform.io"
  organization = "Addresscloud"
  workspaces {
      name = "hello-world-terraform"
    }
  }
}


module "hello-world" {
  source           = "../../../modules/services/lambda"
  deployment       = "dev"
}