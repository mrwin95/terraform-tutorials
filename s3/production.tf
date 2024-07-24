module "s3_terraform_state" {
  source              = "../certificate/modules/s3_terraform_state"
  region              = var.region
  bucket_name         = var.bucket_name
  dynamodb_lock_table = var.dynamodb_lock_table
}
