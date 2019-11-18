output "rds_endpoint" {
  value = "${aws_db_instance.this.endpoint}"
}

output "rds_address" {
  value = "${aws_db_instance.this.address}"
}

# output "db_subnet_group_name" {
#   value = "${aws_db_subnet_group.this.name}"
# }

