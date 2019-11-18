variable "type" {
  description = "ingress/egress security group rule type"
}

variable "from_port" {}

variable "to_port" {}

variable "protocol" {}

variable "cidr_block" {
  type = "list"
}

variable "security_group_id" {}
