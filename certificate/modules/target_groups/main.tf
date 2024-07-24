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

}

resource "aws_lb_target_group_attachment" "lht77_tg_attachment" {
  target_id        = aws_lb_target_group.lht77_ecs_tg.id
  target_group_arn = aws_lb_target_group.lht77_ecs_tg.arn
  port             = 80
}
