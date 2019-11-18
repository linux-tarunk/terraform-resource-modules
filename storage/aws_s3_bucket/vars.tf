variable "project" {
  description = "project"
}

variable "env" {
  description = "environment"
}

variable "created_by" {
  description = "created_by"
}

variable "bucket" {}

variable "acl" {}

variable "lifecycle_rule_id" {}

variable "lifecycle_rule_enabled" {}

variable "object_expiration_days" {}

variable "versioning" {}

variable "force_destroy" {
  default = "false"
}

variable "s3_access_logs_target_bucket_name" {
  description = "Target bucket name for s3 access logging"
}

variable "s3_access_logs_target_prefix" {
  description = "Target bucket prefix to store logs"
}
