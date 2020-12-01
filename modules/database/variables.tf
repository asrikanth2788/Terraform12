# Complete the variable definitions with descriptions, typing, and appropriate default values (where applicable)

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = ""
}

variable "database_port" {
  description = "The port on which to accept connections"
  type        = string
  default     = ""
}

variable "master_username" {
  description = "Master DB username"
  type        = string
  default     = "root"
}

variable "master_password_ssm_path" {
  description = "ssm path to store master password"
  type        = string
  default     = "/credentials/aurorards/master"
}

variable "security_group_ids" {
  description = "List of VPC security groups to associate to the cluster in addition to the SG we create in this module"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "The existing subnet group ids to use"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "An optional map of tags that will be added to all created AWS resources"
  type = map(string)
  default = {}
}