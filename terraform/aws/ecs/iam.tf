data "aws_iam_policy_document" "ssm_parameters" {
  statement {
    sid    = "GetWeblateSSMParameters"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
    ]
    resources = [
      aws_ssm_parameter.weblate_admin_email.arn,
      aws_ssm_parameter.weblate_admin_password.arn,
      aws_ssm_parameter.weblate_google_client_id.arn,
      aws_ssm_parameter.weblate_google_client_secret.arn,
      var.weblate_database_password_secret_arn,
      var.weblate_database_username_secret_arn,
      var.weblate_database_host_secret_arn,
      var.weblate_redis_url_secret_arn,
      var.weblate_redis_auth_token_secret_arn
    ]
  }
}

data "aws_iam_policy_document" "efs_mount" {
  statement {
    effect = "Allow"
    actions = [
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:DescribeMountTargets",
    ]
    resources = [
      aws_efs_file_system.weblate_data.arn
    ]
  }
}