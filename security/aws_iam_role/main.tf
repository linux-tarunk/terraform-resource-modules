resource "aws_iam_role" "this" {
  name               = "${var.name}"
  assume_role_policy = "${var.assume_role_policy}"
  path               = "${var.path}"

  tags {
    Name        = "${var.name}"
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}
