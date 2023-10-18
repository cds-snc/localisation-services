output "ecr_repository_arn_weblate" {
  description = "ARN of the Weblate ECR repository."
  value       = aws_ecr_repository.weblate.arn
}

output "ecr_repository_url_weblate" {
  description = "URL of the Weblate ECR repository."
  value       = aws_ecr_repository.weblate.repository_url
}
