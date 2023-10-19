output "alb_arn" {
  description = "ARN of the load balancer."
  value       = aws_lb.localisation.arn
}

output "alb_target_group_arn" {
  description = "ARN of the load balancer target group."
  value       = aws_lb_target_group.localisation.arn
}
