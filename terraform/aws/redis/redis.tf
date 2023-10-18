#
# Redis: multi-AZ cluster with replication group
#
resource "aws_elasticache_replication_group" "weblate" {
  replication_group_id = "weblate-${var.env}"
  description          = "Weblate multi-AZ cluster"
  engine               = "redis"
  engine_version       = "7.0"
  parameter_group_name = "default.redis7"
  port                 = 6379
  node_type            = var.redis_node_type
  num_cache_clusters   = var.redis_num_cache_clusters

  subnet_group_name           = aws_elasticache_subnet_group.weblate.name
  security_group_ids          = [var.security_group_redis_id]
  preferred_cache_cluster_azs = [for subnet in data.aws_subnet.weblate_private_subnet : subnet.availability_zone]
  multi_az_enabled            = true
  automatic_failover_enabled  = true

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                 = var.redis_auth_token

  maintenance_window = "sun:04:00-sun:05:00"
  apply_immediately  = false

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.weblate_redis_slow_logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.weblate_redis_engine_logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }

  tags = var.common_tags

  lifecycle {
    ignore_changes = [num_cache_clusters]
  }
}

resource "aws_elasticache_subnet_group" "weblate" {
  name        = "weblate-${var.env}"
  description = "Weblate cluster subnet group"
  subnet_ids  = var.subnet_private_ids
}

data "aws_subnet" "weblate_private_subnet" {
  for_each = toset(var.subnet_private_ids)
  id       = each.value
}
