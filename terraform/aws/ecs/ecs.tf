module "localisation_services" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v7.2.11"

  # General
  cluster_name = "localisation-services"
  service_name = "weblate"
  task_cpu     = 1024
  task_memory  = 4096

  # Task definition
  container_image       = "${var.ecr_repository_url_weblate}:latest"
  container_host_port   = 4443
  container_port        = 4443
  container_environment = local.container_environment
  container_secrets     = local.container_secrets
  container_mount_points = [{
    sourceVolume  = local.efs_app_data_name
    containerPath = "/app/data"
    readOnly      = false
  }]

  task_volume = [{
    name = local.efs_app_data_name
    efs_volume_configuration = {
      file_system_id          = aws_efs_file_system.weblate_data.id
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2049
      authorization_config = {
        access_point_id = aws_efs_access_point.weblate_data.id
        iam             = "ENABLED"
      }
    }
  }]

  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ssm_parameters.json
  ]

  task_role_policy_documents = [
    data.aws_iam_policy_document.efs_mount.json
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
