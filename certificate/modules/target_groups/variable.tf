variable "lht77_ecs_tg" {
  type = string
}
variable "vpc_id" {
  type = string
}

variable "healthy_threshold" {
  type = number
}

variable "interval" {
  type = number
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

variable "region" {
  type = string
}
