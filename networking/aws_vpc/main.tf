resource "aws_vpc" "this" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name        = "${var.name}"
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"

  tags = {
    Name        = "${var.name}-igw"
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}

resource "aws_flow_log" "this" {
  log_destination      = "${var.vpc_flow_log_destination_arn}/${var.name}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = "${aws_vpc.this.id}"
}
