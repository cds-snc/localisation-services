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

resource "aws_ssm_parameter" "weblate_github_credentials" {
  name  = "weblate-github-credentials"
  type  = "SecureString"
  value = var.weblate_github_credentials
  tags  = var.common_tags
}

resource "aws_ssm_parameter" "weblate_google_client_id" {
  name  = "weblate-google-client-id"
  type  = "SecureString"
  value = var.weblate_google_client_id
  tags  = var.common_tags
}

resource "aws_ssm_parameter" "weblate_google_client_secret" {
  name  = "weblate-google-client-secret"
  type  = "SecureString"
  value = var.weblate_google_client_secret
  tags  = var.common_tags
}