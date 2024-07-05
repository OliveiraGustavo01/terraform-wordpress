## Tags

variable "tags" {
  description = "Map of tags to provide to the resources created"
  type        = map(string)
  default     = {}
}

## Secret

variable "secret_name" {}

## VPC
variable "vpc_name" {
  description = "Unique name of the VPC that will be outfitted with Routes and Network ACLs"
}



variable "lb_subnet_ids" {
  description = "Subnets where load balancer should be created"
  type        = list(string)
}
##IAM
variable "policy_name" {
  description = "Name to Policy created by ECS"
  type        = string
  default     = "wordpressPolicyEcs"
}
variable "role_name" {
  description = "Name to Role created by ECS"
  type        = string
  default     = "wordpressRoleEcs"
}

## ECS
variable "ecs_cloudwatch_logs_group_name" {
  description = "Name of the Log Group where ECS logs should be written"
  type        = string
  default     = "/ecs/wordpress"
}

variable "ecs_cluster_name" {
  description = "Name for the ECS cluster"
  type        = string
  default     = "wordpress_cluster"
}

variable "ecs_service_container_name" {
  description = "Container name for the container definition and Target Group association"
  type        = string
  default     = "wordpress"
}

variable "ecs_service_name" {
  description = "Name for the ECS Service"
  type        = string
  default     = "wordpress"
}

variable "domain" {
  type        = string
  description = "the DNS name to Wordpress Website - THE SAME THAT ACM ISSUED"

}
variable "ecs_service_desired_count" {
  description = "Number of tasks to have running"
  type        = number
  default     = 2
}

variable "ecs_service_subnet_ids" {
  description = "Subnet ids where ENIs are created for tasks"
  type        = list(string)
}

variable "ecs_service_assign_public_ip" {
  description = "Whether to assign a public IP to the task ENIs"
  type        = bool
  default     = false
}

variable "ecs_task_definition_family" {
  description = "Specify a family for a task definition, which allows you to track multiple versions of the same task definition"
  type        = string
  default     = "wordpress-family"
}

variable "ecs_task_definition_cpu" {
  description = "Number of CPU units reserved for the container in powers of 2"
  type        = string
  default     = "2048"
}

variable "ecs_task_definition_memory" {
  description = "Specify a family for a task definition, which allows you to track multiple versions of the same task definition"
  type        = string
  default     = "4096"
}

## LB

variable "lb_name" {
  description = "Name for the load balancer"
  type        = string
  default     = "wordpress"
}

variable "lb_internal" {
  description = "If the load balancer should be an internal load balancer"
  type        = bool
  default     = false
}

variable "lb_listener_enable_ssl" {
  description = "Enable the SSL listener, if this is set the lb_listener_certificate_arn must also be provided"
  type        = bool
  default     = true
}
variable "lb_listener_ssl_policy" {
  description = "The SSL policy to apply to the HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}


variable "lb_target_group_http" {
  description = "Name of the HTTP target group"
  type        = string
  default     = "wordpress-http"
}

variable "lb_target_group_https" {
  description = "Name of the HTTPS target group"
  type        = string
  default     = "wordpress-https"
}

variable "rds_security_groups_ids" {}


variable "redis_security_groups_ids" {}
variable "target_value_Memory" {
  type    = number
  default = 50
}

variable "target_value_CPU" {
  type    = number
  default = 50
}
