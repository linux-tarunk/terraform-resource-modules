variable "project" {
  description = "project"
}

variable "env" {
  description = "environment"
}

variable "created_by" {
  description = "created_by"
}

variable "s3_bucket" {}

variable "s3_key" {}

variable "function_name" {}

variable "role" {}

variable "handler" {}

variable "runtime" {}

variable "timeout" {}

variable "memory_size" {
  default = "128"
}

variable "description" {}

variable "rds_host" {}

variable "port" {}

variable "name" {}

variable "password" {}

variable "db_name" {}

variable "subnet_ids" {
  type = "list"
}

variable "security_group_ids" {
  type = "list"
}

variable "cert_file" {}

variable "processed_bucket" {}

variable "use_sandbox" {}
