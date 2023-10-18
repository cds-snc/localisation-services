resource "aws_route53_zone" "localisation" {
  name = var.domain
  tags = var.common_tags
}
