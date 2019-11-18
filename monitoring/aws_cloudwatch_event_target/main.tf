resource "aws_cloudwatch_event_target" "this" {
  rule      = "${var.rule}"
  target_id = "${var.target_id}"
  arn       = "${var.arn}"
}
