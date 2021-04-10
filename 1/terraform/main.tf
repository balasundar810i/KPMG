terraform {
  backend "s3" {
    bucket = "terraform-remote-state"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-1"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt = true
  }
}

provider "aws" {
  version = "~> 3.0"
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::ACCOUNT_ID:role/DEPLOYMENT_ROLE_NAME"
  }
}

