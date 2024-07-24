variable "region" {

}

variable "profile_name" {

}
variable "vpc_id" {

}

variable "lht77_ecs_tg" {

}

variable "unhealthy_threshold" {
  type = number
}

variable "timeout" {
  type = number
}

variable "path" {
  type = string
}

variable "port" {
  type = number
}

variable "healthy_threshold" {
  type = number
}

variable "interval" {
  type = number
}

variable "load_balancer_arn" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "api_mapping_headers" {
  type = list([])
}
