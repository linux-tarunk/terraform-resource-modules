variable "name" {}

variable "allocated_storage" {}

variable "max_allocated_storage" {}

variable "storage_type" {}

variable "storage_encrypted" {}

variable "iops" {}

variable "engine" {}

variable "engine_version" {}

variable "instance_class" {}

variable "identifier" {}

# variable "username" {}
#
# variable "password" {}

variable "port" {}

variable "multi_az" {}

variable "publicly_accessible" {}

variable "auto_minor_version_upgrade" {}

variable "skip_final_snapshot" {}

variable "apply_immediately" {}

variable "backup_window" {}

variable "backup_retention_period" {}

variable "maintenance_window" {}

variable "snapshot_identifier" {}

# variable "monitoring_interval" {}
#
# variable "monitoring_role_arn" {}

variable "performance_insights_enabled" {
  default = "false"
}

variable "vpc_security_group_ids" {
  type = "list"
}

variable "subnet_ids" {
  description = "subnet_ids"
  type        = "list"
}

variable "project" {}

variable "env" {}

variable "created_by" {}
