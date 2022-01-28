terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "batman-terraform"
    key    = "ho/ansible_automation"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-2"
}
