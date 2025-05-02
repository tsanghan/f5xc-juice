##################################################################################
# PROVIDERS
##################################################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.1"
    }
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.43"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.7-alpha.2"
    }
  }
}

provider "volterra" {
  timeout = "90s"
  # api_p12_file = "./training.console.ves.volterra.io.api-creds.p12"
  url = "https://training-dev.console.ves.volterra.io/api"
}


provider "aws" {
  region = "ap-southeast-1"
}

provider "http" {}

provider "random" {}

provider "cloudinit" {}