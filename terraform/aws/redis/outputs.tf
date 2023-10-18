output "weblate_redis_auth_token_secret_arn" {
  description = "ARN of the Weblate Redis auth token SSM Parameter"
  value       = aws_ssm_parameter.weblate_redis_auth_token.arn
}

output "weblate_redis_throttle_url_secret_arn" {
  description = "ARN of the Weblate Redis throttle URL SSM Parameter"
  value       = aws_ssm_parameter.weblate_redis_throttle_url.arn
}

output "weblate_redis_url_secret_arn" {
  description = "ARN of the Weblate Redis URL SSM Parameter"
  value       = aws_ssm_parameter.weblate_redis_url.arn
}
