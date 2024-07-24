module "target_groups" {
  source              = "../certificate/modules/target_groups"
  lht77_ecs_tg        = var.lht77_ecs_tg
  vpc_id              = var.vpc_id
  unhealthy_threshold = var.unhealthy_threshold
  interval            = var.interval
  healthy_threshold   = var.healthy_threshold
  path                = var.path
  port                = var.port
  timeout             = var.timeout
  region              = var.region
}
