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
  type = string
}

variable "bucket_name" {
  type    = string
  default = ""
}

variable "dynamodb_lock_table" {
  type    = string
  default = ""
}
