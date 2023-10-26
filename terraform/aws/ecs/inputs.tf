variable "autoscaling_max_capacity" {
  description = "The max number of ECS Weblate tasks to scale up to"
  type        = string
}

variable "autoscaling_min_capacity" {
  description = "The min number of ECS Weblate tasks to scale down to"
  type        = string
}

variable "ecr_repository_url_weblate" {
  description = "URl of the Weblate ECR repository to use for the ECS tasks"
  type        = string
}

variable "lb_target_group_arn" {
  description = "Load balancer target group that will forward traffic to the ECS tasks"
  type        = string
}

variable "security_group_ecs_id" {
  description = "The security group ID to use for the ECS tasks"
  type        = string
}

variable "subnet_private_ids" {
  description = "The private subnet IDs to use for the ECS tasks"
  type        = list(string)
}

variable "weblate_admin_email" {
  description = "Weblate administrator email address"
  type        = string
  sensitive   = true
}

variable "weblate_admin_password" {
  description = "Weblate administrator password"
  type        = string
  sensitive   = true
}

variable "weblate_database_host_secret_arn" {
  description = "Webalate database host SSM parameter ARN"
  type        = string
}

variable "weblate_database_password_secret_arn" {
  description = "Webalate database password SSM parameter ARN"
  type        = string
}

variable "weblate_database_username_secret_arn" {
  description = "Webalate database username SSM parameter ARN"
  type        = string
}

variable "weblate_google_client_id" {
  description = "Weblate Google client ID for OAuth"
  type        = string
  sensitive   = true
}

variable "weblate_google_client_secret" {
  description = "Webalate Google client secret for OAuth"
  type        = string
  sensitive   = true
}

variable "weblate_redis_auth_token_secret_arn" {
  description = "Weblate Redis auth token SSM parameter ARN"
  type        = string
}

variable "weblate_redis_url_secret_arn" {
  description = "Webalate Redis URL SSM parameter ARN"
  type        = string
}