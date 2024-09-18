provider "aws" {
  region = "ap-south-1" 
}

terraform {

  backend "s3" {
    bucket = "example-tf-${var.environment}-states"
    key = "example-${var.environment}-state/terraform.tfstate"
    region = var.aws_region
    dynamodb_table = "example-tf-${var.environment}-locks"
    encrypt = true
  }
}
