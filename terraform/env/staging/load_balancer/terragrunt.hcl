include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../network", "../route53"]
}

dependency "network" {
  config_path = "../network"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    weblate_security_group_lb_id = ""
    weblate_subnet_public_ids    = [""]
    vpc_id                       = ""
  }
}

dependency "route53" {
  config_path = "../route53"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    hosted_zone_id = ""
  }
}

inputs = {
  enable_waf           = true
  hosted_zone_id       = dependency.route53.outputs.hosted_zone_id
  security_group_lb_id = dependency.network.outputs.weblate_security_group_lb_id
  subnet_public_ids    = dependency.network.outputs.weblate_subnet_public_ids
  vpc_id               = dependency.network.outputs.vpc_id
}

terraform {
  source = "../../../aws//load_balancer"
}
