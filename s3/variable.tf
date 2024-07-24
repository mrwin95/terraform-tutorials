variable "region" {
  type        = string
  description = "AWS Deployment region"
}

variable "terraform-storage-s3" {
  type = string
}
variable "terraform-dynamodb-table-locks" {
  type = string
}

variable "profile_name" {
  default = var.profile_name
}

variable "bucket_name" {

}

variable "dynamodb_lock_table" {

}
