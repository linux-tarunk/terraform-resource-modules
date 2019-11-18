resource "aws_lambda_function" "this" {
  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.s3_key}"
  function_name = "${var.function_name}"
  role          = "${var.role}"
  handler       = "${var.handler}"
  runtime       = "${var.runtime}"
  timeout       = "${var.timeout}"
  memory_size   = "${var.memory_size}"
  description   = "${var.description}"

  vpc_config {
    subnet_ids         = ["${var.subnet_ids}"]
    security_group_ids = ["${var.security_group_ids}"]
  }

  environment {
    variables = {
      rds_host         = "${var.rds_host}"
      port             = "${var.port}"
      name             = "${var.name}"
      password         = "${var.password}"
      db_name          = "${var.db_name}"
      cert_file        = "${var.cert_file}"
      processed_bucket = "${var.processed_bucket}"
      use_sandbox      = "${var.use_sandbox}"
    }
  }

  tracing_config {
    mode = "Active"
  }

  tags = {
    Name        = "${var.function_name}"
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}
