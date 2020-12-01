# --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Use the VPC database module you have created
# --------------------------------------------------------------------------------------------------------------------------------------------------------------

module "vpc" {
  source = "./modules/vpc"
  vpc_name = "sudhir-vpc"
  vpc_cidr_block = "10.17.64.0/21"
  subnets = {
    "public" = "10.17.64.0/25"
    "database" = "10.17.65.0/25"
  }
  security_groups = [
    "database",
    "api"
  ]
  internet_gateway = true
  tags = {
    "cost_center" = "1234",
    "project_id" = "recruitment"
  }
}

# --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Use the MySQL database module you have created
# --------------------------------------------------------------------------------------------------------------------------------------------------------------

module "database" {
  source = "./modules/database"
  database_name = "sudhir-database"
  database_port = 1234
  master_username = "eonx_master"
  master_password_ssm_path = "/credentials/sudhir/eonx_master"
  security_group_ids = [
    module.vpc.security_group_ids["database"]
  ]
  subnet_ids = [
    module.vpc.subnet_ids["database"]
  ]
  tags = {
    "cost_center" = "1234",
    "project_id" = "recruitment"
  }
}