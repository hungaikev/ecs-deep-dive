terraform {
  backend "s3" {
    encrypt = true
    bucket = "dj-terraform-state-storage-s3"
    dynamodb_table = "dj-terraform-state-lock-dynamo"
    region = "eu-central-1"
    key = "deepdive/terraform.tfstate"
  }
}