provider "datadog" {
  api_key = var.datadog_api_key
}

# create cluster

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

#c create log groups
resource "aws_cloudwatch_log_group" "ecs_log_groups" {
  name = var.ecs_log_groups
}

# create IAM role

resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.ecs_task_execution_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#attach execution policy to the role
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#Ecs task

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = var.ecs_task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "datadog-agent"
      image     = "public.ecr.aws/datadog/agent:latest"
      essential = true
      evironment = [
        {
          name  = "DD_API_KEY"
          value = var.datadog_api_key
        },
        {
          name  = "ECS_FARGATE"
          value = true
        },
        {
          name  = "DD_LOGS_ENABLED"
          value = true
        },
        {
          name  = "DD_SITE"
          value = "datadoghq.com"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group" : aws_cloudwatch_log_group.ecs_log_groups.name
          "awslogs-region" : var.region
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
    ]
  )
}

resource "aws_ecs_service" "example_datadog" {
  name            = "datadog"
  cluster         = aws_ecs_cluster.ecs_cluster.name
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  #   for_each = toset(var.subnets)
  network_configuration {
    subnets         = ["subnet-756fee39"]
    security_groups = [aws_security_group.ecs_sg.id, aws_security_group.datadog_agent_sg.id]
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "Security group for ECS tasks"

  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "datadog_agent_sg" {
  name        = "datadog_agent_sg"
  description = "Security group for Datadog Agent"

  vpc_id = var.vpc_id

  # No inbound rules needed unless collecting from other services

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
