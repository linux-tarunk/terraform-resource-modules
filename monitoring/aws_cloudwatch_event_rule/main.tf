resource "aws_cloudwatch_event_rule" "this" {
  name                = "${var.name}"
  description         = "${var.description}"
  schedule_expression = "${var.schedule_expression}" //schedule_expression = "cron(0 9 ? * MON-SUN *)"
  is_enabled          = "${var.is_enabled}"
}
