#
# RDS Postgress cluster across 3 subnets
#
module "weblate" {
  source = "github.com/cds-snc/terraform-modules//rds?ref=v7.3.2"
  name   = "weblate-${var.env}"

  database_name  = "weblate"
  engine         = "aurora-postgresql"
  engine_version = "15.3"
  instances      = var.weblate_database_instances_count
  instance_class = var.weblate_database_instance_class
  username       = var.weblate_database_username
  password       = var.weblate_database_password

  backup_retention_period      = 14
  preferred_backup_window      = "02:00-04:00"
  performance_insights_enabled = var.env != "staging"

  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_private_ids
  security_group_ids = [var.security_group_database_id]

  billing_tag_value = var.billing_code
}
