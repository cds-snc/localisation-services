resource "aws_ecr_repository" "weblate" {
  name                 = "platform/localisation-services/weblate"
  image_tag_mutability = "IMMUTABLE"
  tags                 = var.common_tags

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "weblate" {
  repository = aws_ecr_repository.weblate.name
  policy     = file("${path.module}/policy/ecr_cleanup.json")
}
