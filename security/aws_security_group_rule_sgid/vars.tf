variable "type" {
  description = "ingress/egress security group rule type"
}

variable "from_port" {}

variable "to_port" {}

variable "protocol" {}

variable "source_security_group_id" {}

variable "security_group_id" {}
