variable "account_id" {
  description = "(Required) The account ID to perform actions on."
  type        = string
}

variable "cbs_satellite_bucket_name" {
  description = "(Required) Name of the Cloud Based Sensor S3 satellite bucket"
  type        = string
}

variable "common_tags" {
  description = "(Required) The common tags to apply to resources."
  type        = map(string)
}

variable "domain" {
  description = "(Required) Domain name of the localisation service"
  type        = string
}

variable "env" {
  description = "The current running environment"
  type        = string
}

variable "product_name" {
  description = "(Required) The name of the product you are deploying."
  type        = string
}

variable "region" {
  description = "The current AWS region"
  type        = string
}

variable "billing_code" {
  description = "The billing code to tag our resources with"
  type        = string
}
