variable "name" {
  description = "name"
}

variable "project" {
  description = "project"
}

variable "env" {
  description = "environment"
}

variable "created_by" {
  description = "created by"
}

variable "cidr_block" {
  description = "CIDR of VPC"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "enable_dns_support" {
  default = "true"
}

variable "vpc_flow_log_destination_arn" {
  description = "vpc flow log destination arn"
}
