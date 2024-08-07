resource "aws_alb" "application_load_balancer" {
  name                       = "${var.project_name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.public_subnet_az1_id, var.public_subnet_az2_id]
  subnets                    = []
  enable_deletion_protection = true
  tags = {
    "Name" = "${var.project_name}-alb"
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name        = "${var.project_name}-ecs-tg"
  target_type = "ip"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 5
    interval            = 300
    timeout             = 60
    matcher             = 200
    enabled             = true
    path                = "/"
  }
  lifecycle {
    create_before_destroy = true
  }
}

// create http listener

resource "aws_alb_listener" "alb_http_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTPS_301"
    }
  }
}

# create listener on port 443
resource "aws_alb_listener" "alb_https_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }

  certificate_arn = var.certificate_arn
}
