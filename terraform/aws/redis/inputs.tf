variable "redis_auth_token" {
  description = "Redis authentication token."
  type        = string
  sensitive   = true
}

variable "redis_node_type" {
  description = "Instance type to use for cluster nodes."
  type        = string
}

variable "redis_num_cache_clusters" {
  description = "Number of cache clusters (primary and replicas) the replication group will have."
  type        = number
}

variable "security_group_redis_id" {
  description = "Redis security group ID"
  type        = string
}

variable "subnet_private_ids" {
  description = "List of private subnet IDs to deploy the cluster nodes in"
  type        = list(string)
}
