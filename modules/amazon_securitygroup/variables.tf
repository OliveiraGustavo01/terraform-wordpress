variable "name" {
  type    = string
  default = null
}
variable "vpc_id" {
  type    = string
  default = ""
}
variable "description" {
  type    = string
  default = "sg created by terraform"
}
variable "tags" {
  description = "tags for services"
  type        = map(string)
  default     = {}
}
variable "sg_ingress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    ip_protocol              = string
    source_security_group_id = string
    description              = string
  }))
  description = "ingress rules"
}
variable "sg_egress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    ip_protocol              = string
    source_security_group_id = string
    description              = string
  }))
  description = "egress rules"
}
