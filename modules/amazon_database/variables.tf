## Tags

variable "tags" {
  description = "Map of tags to provide to the resources created"
  type        = map(string)
  default     = {}
}

variable "vpc_name" {

  type        = string
  description = "the VPC name"
}


variable "deletion_protection"{
	type = bool
	default = false
	description = "The DB cluster should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false"

}
variable "source_security_group_id" {}

variable "performance_insights_retention_period"{
	type = number
	default = 7
        description = "Retention period to performance insights"
}

variable "performance_insights_enabled"{
     type = bool
     default = true
     description = "Enable performance insights"
}
variable "availability_zones" {}
variable "database_name" {
  type        = string
  default     = ""
  description = "The name of the database"
}

variable "identifier" {
  type        = string
  default     = "wordpress-database"
  description = "The RDS name"

}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "engine" {
  type        = string
  default     = ""
  description = "The type of database engine"
}

variable "engine_version" {
  type        = string
  default     = ""
  description = "The version of the database engine"
}

variable "instance_class" {
  type        = string
  default     = ""
  description = "The instance class for the database"
}

variable "db_subnet_group_name" {
  type        = string
  default     = "private-subnets-wordpress"
  description = "The name of the DB subnet group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs for the database"
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = true
}

variable "master_username" {
  type        = string
  default     = ""
  description = "The username for the database"
}

variable "parameter_group" {
  type        = string
  default     = ""
  description = "The name of the parameter group to associate with this DB instance"
}

variable "multi_az" {
  type    = bool
  default = false

}
