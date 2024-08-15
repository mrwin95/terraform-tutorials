variable "cluster_name" {}
variable "ecs_log_groups" {}
variable "ecs_task_execution_role" {}
variable "ecs_task_family" {}
variable "cpu" {}
variable "memory" {}
variable "datadog_api_key" {}
variable "region" {}
variable "vpc_id" {}
variable "subnets" {
  type = list(string)
}
