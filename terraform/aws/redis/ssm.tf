resource "aws_ssm_parameter" "weblate_redis_auth_token" {
  name  = "weblate-redis-auth_token"
  type  = "SecureString"
  value = var.redis_auth_token
  tags  = var.common_tags
}

resource "aws_ssm_parameter" "weblate_redis_url" {
  name  = "weblate-redis-url"
  type  = "SecureString"
  value = aws_elasticache_replication_group.weblate.primary_endpoint_address
  tags  = var.common_tags
}
