terraform {
  backend "s3" {
    bucket         = "terraforms3backend2025"
    key            = "Eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
