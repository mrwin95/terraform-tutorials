resource "aws_lb_target_group" "lht77_ecs_tg" {
  name        = var.lht77_ecs_tg
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    healthy_threshold   = var.healthy_threshold
    interval            = var.interval
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    path                = var.path
    port                = var.port
  }

  ip_address_type = "ipv4"
}

resource "aws_lb_target_group_attachment" "lht77_tg_attachment" {
  target_id        = aws_lb_target_group.lht77_ecs_tg.id
  target_group_arn = aws_lb_target_group.lht77_ecs_tg.arn
  port             = 80
}

resource "aws_alb_listener" "lb_listener_http" {
  load_balancer_arn = var.load_balancer_arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.lht77_ecs_tg.id
    type             = "forward"
  }
}

# Listener rule for HTTPs traffic

resource "aws_alb_listener" "lb_listner_https" {
  certificate_arn   = var.certificate_arn
  load_balancer_arn = var.load_balancer_arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lht77_ecs_tg.id
  }
}

resource "aws_alb_listener_rule" "api_rule_http" {
  tags = {
    "Name" : "${var.api_mapping_headers}"
  }

  listener_arn = aws_alb_listener.lb_listener_http.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lht77_ecs_tg.arn
  }

  condition {
    host_header {
      values = ["${var.api_mapping_headers}"]
    }
  }
}

resource "aws_alb_listener_rule" "api_rule_https" {
  tags = {
    "Name" : "${var.api_mapping_headers}"
  }

  listener_arn = aws_alb_listener.lb_listner_https.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lht77_ecs_tg.arn
  }
  condition {
    host_header {
      values = ["${var.api_mapping_headers}"]
    }
  }
}
