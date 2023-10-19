variable "enable_waf" {
  description = "Enable WAF for the load balancer"
  type        = bool
}

variable "hosted_zone_id" {
  description = "Hosted zone ID for the DNS records"
  type        = string
}

variable "security_group_lb_id" {
  description = "ID of the security group to attach to the load balancer"
  type        = string
}

variable "subnet_public_ids" {
  description = "Public subnet IDs to attach the load balancer to"
  type        = list(any)
}

variable "vpc_id" {
  description = "VPC ID for the load balancer"
  type        = string
}


