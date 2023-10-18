#
# VPC: 3 public + 3 private subnets across 3 availability zones
#
module "weblate_vpc" {
  source = "github.com/cds-snc/terraform-modules//vpc?ref=v7.2.0"
  name   = "weblate-${var.env}"

  high_availability  = true
  enable_flow_log    = true
  single_nat_gateway = var.env == "staging"

  allow_https_request_out          = true
  allow_https_request_out_response = true
  allow_https_request_in           = true
  allow_https_request_in_response  = true

  billing_tag_value = var.billing_code
}

# Required to redirect http requests to https
resource "aws_network_acl_rule" "port_80" {
  network_acl_id = module.weblate_vpc.main_nacl_id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}
