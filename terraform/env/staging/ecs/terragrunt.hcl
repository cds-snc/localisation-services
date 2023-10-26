include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../network", "../ecr", "../load_balancer", "../database", "../redis"]
}

dependency "network" {
  config_path = "../network"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    weblate_security_group_ecs_id = ""
    weblate_security_group_efs_id = ""
    weblate_subnet_private_ids    = [""]
    vpc_id                        = ""
  }
}

dependency "ecr" {
  config_path = "../ecr"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    ecr_repository_url_weblate = ""
  }
}

dependency "load_balancer" {
  config_path = "../load_balancer"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    alb_target_group_arn = ""
  }
}

dependency "database" {
  config_path = "../database"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    weblate_database_host_secret_arn     = ""
    weblate_database_username_secret_arn = ""
    weblate_database_password_secret_arn = ""
  }
}

dependency "redis" {
  config_path = "../redis"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    weblate_redis_auth_token_secret_arn = ""
    weblate_redis_url_secret_arn        = ""
  }
}

inputs = {
  autoscaling_max_capacity             = 2
  autoscaling_min_capacity             = 1
  ecr_repository_url_weblate           = dependency.ecr.outputs.ecr_repository_url_weblate
  lb_target_group_arn                  = dependency.load_balancer.outputs.alb_target_group_arn
  security_group_ecs_id                = dependency.network.outputs.weblate_security_group_ecs_id
  security_group_efs_id                = dependency.network.outputs.weblate_security_group_efs_id
  subnet_private_ids                   = dependency.network.outputs.weblate_subnet_private_ids
  weblate_database_host_secret_arn     = dependency.database.outputs.weblate_database_host_secret_arn
  weblate_database_username_secret_arn = dependency.database.outputs.weblate_database_username_secret_arn
  weblate_database_password_secret_arn = dependency.database.outputs.weblate_database_password_secret_arn
  weblate_redis_auth_token_secret_arn  = dependency.redis.outputs.weblate_redis_auth_token_secret_arn
  weblate_redis_url_secret_arn         = dependency.redis.outputs.weblate_redis_url_secret_arn
}

terraform {
  source = "../../../aws//ecs"
}
