output "weblate_security_group_ecs_id" {
  description = "Weblate ECS task security group ID"
  value       = aws_security_group.weblate_ecs.id
}

output "weblate_security_group_database_id" {
  description = "Weblate database security group ID"
  value       = aws_security_group.weblate_database.id
}

output "weblate_security_group_lb_id" {
  description = "Weblate load balancer security group ID"
  value       = aws_security_group.weblate_lb.id
}

output "weblate_security_group_redis_id" {
  description = "Weblate Redis security group ID"
  value       = aws_security_group.weblate_redis.id
}

output "weblate_subnet_private_ids" {
  description = "Weblate list of the private subnet IDs"
  value       = module.weblate_vpc.private_subnet_ids
}

output "weblate_subnet_public_ids" {
  description = "Weblate list of the public subnet IDs"
  value       = module.weblate_vpc.public_subnet_ids
}

output "vpc_id" {
  description = "Weblate VPC ID"
  value       = module.weblate_vpc.vpc_id
}
