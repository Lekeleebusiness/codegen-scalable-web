terraform {
  backend "s3" {
    bucket         = "codegen-remote-backend"
    key            = "codegen-backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "codegen-state-lock"
  }
}