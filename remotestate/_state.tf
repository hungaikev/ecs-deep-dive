provider "aws" {
  profile = "default"
  region = "eu-central-1"
}

## Terraform state file setup
## Creat an s3 bucket to store the state file in
resource "aws_s3_bucket" "dj-terraform-state-storage-s3" {
  bucket = "dj-terraform-state-storage-s3"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "s3 Remote Terraform State Store"
  }
}

## Create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dj-dynamo-terraform-state-lock" {
  hash_key = "LockID"
  name = "dj-terraform-state-lock-dynamo"
  read_capacity = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}