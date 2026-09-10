provider "aws" {
  region = "ap-southeast-2"
}

terraform {
  backend "s3" {
    key          = "tf-dumcloud-infra"
    region       = "ap-southeast-2"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
