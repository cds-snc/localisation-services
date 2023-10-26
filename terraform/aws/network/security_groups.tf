#
# ECS tasks
#
resource "aws_security_group" "weblate_ecs" {
  name        = "weblate-ecs"
  description = "Weblate ECS task"
  vpc_id      = module.weblate_vpc.vpc_id
  tags        = var.common_tags
}

resource "aws_security_group_rule" "weblate_ecs_ingress_lb" {
  description              = "Ingress from load balancer to Weblate ECS task"
  type                     = "ingress"
  from_port                = 4443
  to_port                  = 4443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.weblate_ecs.id
  source_security_group_id = aws_security_group.weblate_lb.id
}

resource "aws_security_group_rule" "weblate_egress_internet" {
  description       = "Egress from Weblate ECS task to internet"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.weblate_ecs.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "weblate_egress_database" {
  description              = "Egress from Weblate ECS task to database"
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.weblate_ecs.id
  source_security_group_id = aws_security_group.weblate_database.id
}

resource "aws_security_group_rule" "weblate_egress_redis" {
  description              = "Egress from Weblate ECS task to Redis"
  type                     = "egress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.weblate_ecs.id
  source_security_group_id = aws_security_group.weblate_redis.id
}

resource "aws_security_group_rule" "weblate_egress_efs" {
  description              = "Egress from Weblate ECS task to EFS"
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.weblate_ecs.id
  source_security_group_id = aws_security_group.weblate_efs.id
}

#
# Load balancer
#
resource "aws_security_group" "weblate_lb" {
  name        = "weblate-lb"
  description = "Weblate load balancer - ingress from internet, egress to ECS"
  vpc_id      = module.weblate_vpc.vpc_id
  tags        = var.common_tags
}

resource "aws_security_group_rule" "weblate_lb_ingress_internet_http" {
  description       = "Ingress from internet to load balancer (HTTP)"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.weblate_lb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "weblate_lb_ingress_internet_https" {
  description       = "Ingress from internet to load balancer (HTTPS)"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.weblate_lb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "weblate_lb_egress_ecs" {
  description              = "Egress from load balancer to Weblate ECS task"
  type                     = "egress"
  from_port                = 4443
  to_port                  = 4443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.weblate_lb.id
  source_security_group_id = aws_security_group.weblate_ecs.id
}

#
# Database
#
resource "aws_security_group" "weblate_database" {
  name        = "weblate-database"
  description = "Weblate database - ingress from ECS"
  vpc_id      = module.weblate_vpc.vpc_id
  tags        = var.common_tags
}

resource "aws_security_group_rule" "weblate_database_ingress_ecs" {
  description              = "Ingress from Weblate ECS task to database"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.weblate_database.id
  source_security_group_id = aws_security_group.weblate_ecs.id
}

#
# Redis
#
resource "aws_security_group" "weblate_redis" {
  name        = "weblate-redis"
  description = "Weblate Redis - ingress from ECS"
  vpc_id      = module.weblate_vpc.vpc_id
  tags        = var.common_tags
}

resource "aws_security_group_rule" "weblate_redis_ingress_ecs" {
  description              = "Ingress from Weblate ECS task to Redis"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.weblate_redis.id
  source_security_group_id = aws_security_group.weblate_ecs.id
}

#
# EFS
#
resource "aws_security_group" "weblate_efs" {
  name        = "weblate-efs"
  description = "Weblate EFS - ingress from ECS"
  vpc_id      = module.weblate_vpc.vpc_id
  tags        = var.common_tags
}

resource "aws_security_group_rule" "weblate_efs_ingress_ecs" {
  description              = "Ingress from Weblate ECS task to EFS"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.weblate_efs.id
  source_security_group_id = aws_security_group.weblate_ecs.id
}