resource "aws_s3_bucket" "this" {
  bucket        = "${var.bucket}"
  acl           = "${var.acl}"
  force_destroy = "${var.force_destroy}"

  versioning {
    enabled = "${var.versioning}"
  }

  lifecycle_rule {
    id      = "${var.lifecycle_rule_id}"
    enabled = "${var.lifecycle_rule_enabled}"

    expiration {
      days = "${var.object_expiration_days}"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "${var.s3_access_logs_target_bucket_name}"
    target_prefix = "${var.s3_access_logs_target_prefix}"
  }

  tags = {
    Name        = "${var.bucket}"
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}
