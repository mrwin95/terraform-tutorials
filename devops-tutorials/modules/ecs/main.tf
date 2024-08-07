resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = var.ecs_log_group
}

# create IAM role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.ecs_task_execution_role
  assume_role_policy = jsondecode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect : "Allow",
        "Principal" = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })
}
