output "cloudwatch_event_rule_name" {
  value = "${aws_cloudwatch_event_rule.this.name}"
}

output "cloudwatch_event_rule_arn" {
  value = "${aws_cloudwatch_event_rule.this.arn}"
}
