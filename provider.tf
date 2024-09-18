provider "aws" {
  region = "ap-south-1" 
}

terraform {

  backend "s3" {
    bucket = "terraform-be-worley-test-states"
    key = "terraform-be-worley-test-state/terraform.tfstate"
    region = ap-south-1
  }
}
