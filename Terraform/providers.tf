terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = var.aws_region
  shared_config_files      = ["/Users/tf_user/.aws/config"]
  shared_credentials_files = ["/Users/payalchavan/.aws/credentials"]
  profile                  = "iamadmin-general"
}