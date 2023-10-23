resource "aws_ssm_parameter" "weblate_admin_email" {
  name  = "weblate-admin-email"
  type  = "SecureString"
  value = var.weblate_admin_email
  tags  = var.common_tags
}

resource "aws_ssm_parameter" "weblate_admin_password" {
  name  = "weblate-admin-password"
  type  = "SecureString"
  value = var.weblate_admin_password
  tags  = var.common_tags
}