module "localisation_services" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v7.2.5"

  # General
  cluster_name = "localisation-services"
  service_name = "weblate"
  task_cpu     = 2048
  task_memory  = 4096

  # Task definition
  container_image       = var.ecr_repository_url_weblate
  container_host_port   = 4443
  container_port        = 4443
  container_environment = local.container_environment
  container_secrets     = local.container_secrets
  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ssm_parameters.json
  ]

  # Scaling
  enable_autoscaling       = true
  desired_count            = var.autoscaling_min_capacity
  autoscaling_min_capacity = var.autoscaling_min_capacity
  autoscaling_max_capacity = var.autoscaling_max_capacity

  # Networking
  lb_target_group_arn = var.lb_target_group_arn
  security_group_ids  = [var.security_group_ecs_id]
  subnet_ids          = var.subnet_private_ids

  billing_tag_value = var.billing_code
}
