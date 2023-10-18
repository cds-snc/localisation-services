resource "aws_ssm_parameter" "weblate_database_host" {
  name  = "weblate-database-host"
  type  = "SecureString"
  value = module.weblate.proxy_endpoint
  tags  = var.common_tags
}

resource "aws_ssm_parameter" "weblate_database_username" {
  name  = "weblate-database-username"
  type  = "SecureString"
  value = var.weblate_database_username
  tags  = var.common_tags
}

resource "aws_ssm_parameter" "weblate_database_password" {
  name  = "weblate-database-password"
  type  = "SecureString"
  value = var.weblate_database_password
  tags  = var.common_tags
}
