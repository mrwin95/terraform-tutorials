variable "region" {
  default     = "us-east-1" // can update to another region
  type        = string
  description = "AWS Deployment region"
}

variable "domain_name" {
  type        = string
  description = "Your domain name"
}

variable "terraform-storage-s3-bucket" {
  type = string
}
variable "terraform-dynamodb-table-locks" {
  type = string
}

variable "profile_name" {
  
}