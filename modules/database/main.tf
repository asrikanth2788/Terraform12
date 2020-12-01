# Create Terraform module here


resource "aws_rds_cluster_instance" "aurora_cluster_instances" {

  identifier                        = "${var.database_name}-aurora-mysql-cluster-instance"
  cluster_identifier                 = aws_rds_cluster.aurora_cluster.id
  instance_class                     = "db.t2.medium"
  engine                             = aws_rds_cluster.aurora_cluster.engine
  engine_version                     = aws_rds_cluster.aurora_cluster.engine_version
  #db_subnet_group_name              = aws_db_subnet_group.db_subnet_group.name
  preferred_maintenance_window       = "sun:04:00-sun:04:30"
  availability_zone                  = data.aws_subnet.input.availability_zone
  #storage_encrypted                  = true
  tags                               = merge({ 
                                        Name = "${var.database_name}-aurora-cluster-instance",
                                       }, var.tags
                                       )
}

resource "aws_rds_cluster" "aurora_cluster" {

  database_name                       = replace(var.database_name,"/[^a-z0-9]/", "")
  port                                = var.database_port
  master_username                     = var.master_username
  master_password                     = random_string.db_password.result
  vpc_security_group_ids              = var.security_group_ids
  db_subnet_group_name                = aws_db_subnet_group.db_subnet_group.name
  cluster_identifier                  = "${var.database_name}-aurora-mysql-cluster"
  engine                              = "aurora-mysql"
  engine_version                      = "5.7.mysql_aurora.2.03.2"
  backup_retention_period             = 5
  preferred_backup_window             = "07:00-09:00"
  skip_final_snapshot                 = true
  enabled_cloudwatch_logs_exports     = ["audit","error","slowquery"]
  preferred_maintenance_window        = "sun:04:00-sun:04:30"
  tags                                = merge({ 
                                          Name = "${var.database_name}-aurora-cluster",
                                          }, var.tags
                                        )
  
}


resource "random_string" "db_password" {
  length = 16
  special = true
  override_special = "!#$%&*()-_=+{}[]<>:?"
}

resource "aws_ssm_parameter" "db_password" {
  name = var.master_password_ssm_path
  type = "SecureString"
  value = random_string.db_password.result

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}



resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.database_name}-db-subnet-group"
  subnet_ids = length(var.subnet_ids) == 1 ? data.aws_subnet_ids.subnet_ids.ids : var.subnet_ids
  #subnet_ids = data.aws_subnet.test_subnet.*.id
  #subnet_ids =[
  #  for name, cidr in aws_subnet.subnet:
  #  aws_subnet.subnet[name].id
  #] 

  tags = merge({ 
    Name = "${var.database_name}-db-subnet-group",
  },
  var.tags)

}



data "aws_subnet" "input" {
 id = var.subnet_ids[0]
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = data.aws_subnet.input.vpc_id
}



resource "aws_security_group_rule" "sg_rule" {
  count = length(var.security_group_ids)

  description = "Add Inbound security rule"

  type              = "ingress"
  from_port         = aws_rds_cluster.aurora_cluster.port
  to_port           = aws_rds_cluster.aurora_cluster.port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = element(var.security_group_ids, count.index)
}


##resource "aws_kms_key" "kms_key" {
##  description             = "KMS key for Aurora RDS"
##  deletion_window_in_days = 10
##}
##
##resource "aws_kms_alias" "kms_key_alias" {
##  name          = "alias/rds/aurora/key"
##  target_key_id = aws_kms_key.kms_key.key_id
##}