terraform {
  backend "s3" {
    bucket         = "terraform-storage-state-2024"
    key            = "workspaces-lht77.com/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
    # workspace_key_prefix = var.workspace_key_prefix
    # workspaces           = ""
  }
}
provider "aws" {
  region  = var.region
  profile = var.profile_name
}
