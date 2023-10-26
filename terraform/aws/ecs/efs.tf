resource "aws_efs_file_system" "weblate_data" {
  encrypted = true
  tags      = var.common_tags
}

resource "aws_efs_file_system_policy" "weblate_data" {
  file_system_id = aws_efs_file_system.weblate_data.id
  policy         = data.aws_iam_policy_document.efs_access_point_secure.json
}

data "aws_iam_policy_document" "efs_access_point_secure" {
  statement {
    sid    = "AllowAccessThroughAccessPoint"
    effect = "Allow"
    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
    ]
    resources = [aws_efs_file_system.weblate_data.arn]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEquals"
      variable = "elasticfilesystem:AccessPointArn"
      values = [
        aws_efs_access_point.weblate_data.arn
      ]
    }
  }

  statement {
    sid       = "DenyNonSecureTransport"
    effect    = "Deny"
    actions   = ["*"]
    resources = [aws_efs_file_system.weblate_data.arn]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

resource "aws_efs_backup_policy" "weblate_data" {
  file_system_id = aws_efs_file_system.weblate_data.id
  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "weblate_data" {
  for_each = toset(var.subnet_private_ids)

  file_system_id = aws_efs_file_system.weblate_data.id
  subnet_id      = each.value
  security_groups = [
    var.security_group_efs_id
  ]
}

resource "aws_efs_access_point" "weblate_data" {
  file_system_id = aws_efs_file_system.weblate_data.id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/app/data"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = 750
    }
  }
  tags = var.common_tags
}
