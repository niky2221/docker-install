terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.49.0"
    }
  }
  backend "s3" {
    bucket         = "expense-tf-statefile"
    key            = "docker-key" #you shold unique key name in bucket, same key should not be used in repos or another any files
    region         = "us-east-1"
    dynamodb_table = "expense-tf-statelocking"
    use_lockfile   = false
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}