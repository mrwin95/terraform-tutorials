terraform {
  backend "s3" {
    bucket         = "terraform-storage-state-2024"
    key            = "workspaces-mumbai/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }

  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.16" # Specify the version you want
    }
  }
}

