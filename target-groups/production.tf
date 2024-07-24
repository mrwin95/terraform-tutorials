module "target_groups" {
  source              = "../certificate/modules/target_groups"
  lht77_ecs_tg        = var.lht77_ecs_tg
  vpc_id              = var.vpc_id
  unhealthy_threshold = var.unhealthy_threshold
  interval            = "30s"
  healthy_threshold   = "5"
  path                = "/healthcheck"
  port                = var.port
  timeout             = var.timeout
}
