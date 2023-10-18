resource "aws_cloudwatch_log_group" "weblate_redis_slow_logs" {
  name              = "/aws/elasticache/weblate/slow-logs"
  retention_in_days = 7
  tags              = var.common_tags
}

resource "aws_cloudwatch_log_group" "weblate_redis_engine_logs" {
  name              = "/aws/elasticache/weblate/engine-logs"
  retention_in_days = 7
  tags              = var.common_tags
}
