resource "aws_route_table" "this" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.gateway_id}"
  }

  tags {
    Name        = "${var.name}"
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}
