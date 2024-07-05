variable "engine"{}
variable "engine_version"{}
variable "replication_group_id" {}
variable "replication_group_description" {}
variable "node_type" {}
variable "number_cache_clusters" {}
variable "log_format" {}
variable "log_type" {}
variable "family"{}
variable "port" {
  type    = number
  default = 6379
}
variable "subnet_ids" {
  type        = list(string)
  description = "List of VPC Subnet IDs for the cache subnet group"
}
variable "security_group_ids" {
  description = "A list of Security Group ID's to allow access to."
  type        = list(string)
  default     = []
}
variable "transit_encryption_enabled" {
  description = "Whether to enable encryption in transit. Requires 3.2.6 or >=4.0 redis_version"
  type        = bool
  default     = false
}

variable "auth_token" {
  description = "The password used to access a password protected server."
  type        = string
  default     = null
  sensitive   = true
}

variable "parameters" {
  description = "additional parameters modifyed in parameter group"
  type        = list(map(any))
  default     = []
}
variable "redis_maintenance_window" {
  description = "format is ddd:hh24:mi-ddd:hh24:mi"
  type        = string
  default     = "sat:08:00-sat:09:00"
}
variable "snapshot_window" {
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period"
  type        = string
  default     = "06:30-07:30"
}

variable "snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them."
  type        = number
  default     = 5
}
variable "automatic_failover_enabled" {
  type    = bool
  default = false
}

variable "redis_parameters" {
  description = "additional parameters modifyed in parameter group"
  type        = list(map(any))
  default     = []
}

variable "multi_az_enabled" {
  type    = bool
  default = false
}

variable "apply_immediately" {
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
  type        = bool
  default     = true
}
variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
