resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.name}-sg-${var.env}"
  subnet_ids = ["${var.subnet_ids}"]
}

resource "aws_db_parameter_group" "this" {
  name        = "${var.project}-${var.name}-pg-${var.env}"
  description = "mysql parameter group"
  family      = "mysql5.6"

  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }

  parameter {
    name  = "event_scheduler"
    value = "on"
  }
}

resource "aws_db_instance" "this" {
  allocated_storage     = "${var.allocated_storage}"
  max_allocated_storage = "${var.max_allocated_storage}"
  storage_type          = "${var.storage_type}"
  storage_encrypted     = "${var.storage_encrypted}"
  iops                  = "${var.iops}"
  engine                = "${var.engine}"
  engine_version        = "${var.engine_version}"
  instance_class        = "${var.instance_class}"
  identifier            = "${var.identifier}"
  name                  = "${var.name}"

  # username                   = "${var.username}"
  # password                   = "${var.password}"
  port = "${var.port}"

  multi_az                   = "${var.multi_az}"
  publicly_accessible        = "${var.publicly_accessible}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  skip_final_snapshot        = "${var.skip_final_snapshot}"
  apply_immediately          = "${var.apply_immediately}"
  backup_window              = "${var.backup_window}"
  backup_retention_period    = "${var.backup_retention_period}"
  maintenance_window         = "${var.maintenance_window}"
  snapshot_identifier        = "${var.snapshot_identifier}"

  # monitoring_interval  = "${var.monitoring_interval}"
  # monitoring_role_arn  = "${var.monitoring_role_arn}"
  performance_insights_enabled = "${var.performance_insights_enabled}"

  db_subnet_group_name = "${aws_db_subnet_group.this.name}"

  vpc_security_group_ids          = ["${var.vpc_security_group_ids}"]
  parameter_group_name            = "${aws_db_parameter_group.this.name}"
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags {
    Name        = "${var.name}"
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}
