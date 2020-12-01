# Complete the output definitions below- replace all values with the real values from the provisioned infrastructure

output "database_endpoint" {
  # Replace example output below
  description = "The DNS address of the aurora RDS instance "
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "database_port" {
  # Complete values below
  description = "the port of aurora RDS instance"
  value = aws_rds_cluster.aurora_cluster.port
}

# Complete the output definitions below with appropriate descriptions and values
output "database_name" {
  # Complete values below
  description = "database name of aurora rds"
  value = aws_rds_cluster.aurora_cluster.database_name
}

output "master_username" {
  # Complete values below
  description = "master username for aurora rds instance"
  value = aws_rds_cluster.aurora_cluster.master_username
}

output "master_password" {
  # Complete values below
  description = "master user password to login to the aurora rds instace"
  value = random_string.db_password.result
}
