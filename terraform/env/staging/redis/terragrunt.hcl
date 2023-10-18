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
    weblate_security_group_redis_id = ""
    weblate_subnet_private_ids      = [""]
  }
}

inputs = {
  redis_node_type          = "cache.t3.micro"
  redis_num_cache_clusters = 3
  security_group_redis_id  = dependency.network.outputs.weblate_security_group_redis_id
  subnet_private_ids       = dependency.network.outputs.weblate_subnet_private_ids
}

terraform {
  source = "../../../aws//redis"
}
