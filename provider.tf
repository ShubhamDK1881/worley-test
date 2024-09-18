provider "aws" {
  region     = "ap-South-1"
  access_key = secret.aws_access_key
  secret_key = secret.aws_secret_key
}


terraform {

  backend "s3" {
    bucket = "terraform-be-worley-test-states"
    key = "terraform-be-worley-test-state/terraform.tfstate"
    region = "ap-south-1"
  }
}
