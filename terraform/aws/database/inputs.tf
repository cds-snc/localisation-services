variable "weblate_database_instances_count" {
  description = "Number of database instances to create in the cluster"
  type        = number
}

variable "weblate_database_instance_class" {
  description = "Database instance class used in the cluster"
  type        = string
}

variable "weblate_database_username" {
  description = "Username for the database user"
  type        = string
  sensitive   = true
}

variable "weblate_database_password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}

variable "security_group_database_id" {
  description = "Database security group ID"
  type        = string
}

variable "subnet_private_ids" {
  description = "List of private subnet IDs to deploy the database in"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID to deploy the database in"
  type        = string
}
