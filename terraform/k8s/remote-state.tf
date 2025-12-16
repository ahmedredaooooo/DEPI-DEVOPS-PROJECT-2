terraform {
  required_version = ">= 1.3.0"

  backend "s3" {
    bucket         = "dev-ops-terraform-state"
    key            = "k8s/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}