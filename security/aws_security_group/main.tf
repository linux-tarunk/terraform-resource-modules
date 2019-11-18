resource "aws_security_group" "this" {
  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.name}"
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}
