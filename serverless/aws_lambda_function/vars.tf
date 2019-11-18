variable "s3_bucket" {}

variable "s3_key" {}

variable "function_name" {}

variable "role" {}

variable "handler" {}

variable "runtime" {}

variable "timeout" {}

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

variable "project" {}

variable "env" {}

variable "created_by" {}
