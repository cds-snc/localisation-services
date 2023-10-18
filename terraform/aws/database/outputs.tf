output "weblate_database_host_secret_arn" {
  description = "ARN of the database host SSM Parameter"
  value       = aws_ssm_parameter.weblate_database_host.arn
}

output "weblate_database_username_secret_arn" {
  description = "ARN of the database username SSM Parameter"
  value       = aws_ssm_parameter.weblate_database_username.arn
}

output "weblate_database_password_secret_arn" {
  description = "ARN of the database password SSM Parameter"
  value       = aws_ssm_parameter.weblate_database_password.arn
}

output "weblate_rds_cluster_id" {
  description = "Weblate RDS cluster ID"
  value       = module.weblate.rds_cluster_id
}
