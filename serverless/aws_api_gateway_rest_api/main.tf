resource "aws_api_gateway_rest_api" "this" {
  name = "${var.name}"

  endpoint_configuration {
    types = ["${var.endpoint_configuration_types}"]
  }
}
