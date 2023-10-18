locals {
  product_name = "localisation-services"
  vars         = read_terragrunt_config("../env_vars.hcl")
}

inputs = {
  
  account_id                = local.vars.inputs.account_id
  billing_code              = local.vars.inputs.cost_center_code
  cbs_satellite_bucket_name = "cbs-satellite-${local.vars.inputs.account_id}"
  domain                    = local.vars.inputs.domain
  env                       = local.vars.inputs.env
  product_name              = local.product_name
  region                    = "ca-central-1"

  common_tags = {
    CostCentre  = local.vars.inputs.cost_center_code
    Environment = local.vars.inputs.env
    Product     = local.product_name
    Terraform   = "true"
  }  
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = file("./common/provider.tf")

}

generate "common_variables" {
  path      = "common_variables.tf"
  if_exists = "overwrite"
  contents  = file("./common/common_variables.tf")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    encrypt             = true
    bucket              = "${local.product_name}-tf"
    dynamodb_table      = "tfstate-lock"
    region              = "ca-central-1"
    key                 = "${path_relative_to_include()}/terraform.tfstate"
    s3_bucket_tags      = { CostCentre : local.vars.inputs.cost_center_code }
    dynamodb_table_tags = { CostCentre : local.vars.inputs.cost_center_code }
  }
}
