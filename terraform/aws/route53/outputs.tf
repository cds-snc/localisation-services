output "hosted_zone_id" {
  description = "Route53 hosted zone ID that will hold the DNS records"
  value       = aws_route53_zone.localisation.zone_id
}
