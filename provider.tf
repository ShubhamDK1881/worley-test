provider "aws" {
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_REGION: ap-south-1
}

terraform {

  backend "s3" {
    bucket = "terraform-be-worley-test-states"
    key = "terraform-be-worley-test-state/terraform.tfstate"
    region = "ap-south-1"
  }
}
