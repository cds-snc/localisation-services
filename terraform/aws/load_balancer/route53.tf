resource "aws_route53_record" "localisation_A" {
  zone_id = var.hosted_zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_lb.localisation.dns_name
    zone_id                = aws_lb.localisation.zone_id
    evaluate_target_health = false
  }
}
