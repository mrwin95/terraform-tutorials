# resource "aws_dynamodb_table" "terraform_state_lock" {
#   name         = "terraform-up-and-running-locks"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }


terraform {
  backend "s3" {
    bucket         = "mumbai-terraform-storage-state-2024"
    key            = "workspaces-mumbai/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
