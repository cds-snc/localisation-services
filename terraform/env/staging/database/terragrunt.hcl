include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../network"]
}

dependency "network" {
  config_path = "../network"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    weblate_security_group_database_id = ""
    weblate_subnet_private_ids         = [""]
    vpc_id                             = ""
  }
}

inputs = {
  weblate_database_instances_count = 2
  weblate_database_instance_class  = "db.t3.medium"
  security_group_database_id       = dependency.network.outputs.weblate_security_group_database_id
  subnet_private_ids               = dependency.network.outputs.weblate_subnet_private_ids
  vpc_id                           = dependency.network.outputs.vpc_id
}

terraform {
  source = "../../../aws//database"
}
