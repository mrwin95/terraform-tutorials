variable "region" {
  default     = "ap-northeast-1"
  type        = string
  description = "The region name"
}

variable "domain_name" {
  default     = "test.co"
  type        = string
  description = "The region name"
}

variable "zone_id" {
  default     = ""
  type        = string
  description = "The region name"
}

variable "record_name" {
  default     = "www"
  type        = string
  description = "www sub domain name"
}

variable "api_record_name" {
  default     = "api"
  type        = string
  description = "api sub domain name"
}

variable "alb_dns_name" {
  default     = var.alb_dns_name
  type        = string
  description = "api sub domain name"
}

variable "alb_zone_id" {
  default     = "api"
  type        = string
  description = "api sub domain name"
}
