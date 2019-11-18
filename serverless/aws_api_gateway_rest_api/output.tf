output "rest_api_id" {
  value = "${aws_api_gateway_rest_api.this.id}"
}

output "rest_api_root_resource_id" {
  value = "${aws_api_gateway_rest_api.this.root_resource_id}"
}

output "rest_api_execution_arn" {
  value = "${aws_api_gateway_rest_api.this.execution_arn}"
}
