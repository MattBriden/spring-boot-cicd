terraform {
  backend "s3" {}
  required_version = ">= 1.0.0, < 1.1.0"
}

provider "aws" {
  region = var.region
  profile = var.profile
}
