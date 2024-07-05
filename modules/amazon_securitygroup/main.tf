resource "aws_security_group" "example" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = var.tags
}
resource "aws_vpc_security_group_egress_rule" "example" {
  security_group_id        = aws_security_group.example.id
  count                    = length(var.sg_egress_rules)
  from_port                = var.sg_egress_rules[count.index].from_port
  to_port                  = var.sg_egress_rules[count.index].to_port
  referenced_security_group_id  = var.sg_ingress_rules[count.index].source_security_group_id
  ip_protocol              = var.sg_egress_rules[count.index].ip_protocol
}
resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id        = aws_security_group.example.id
  count                    = length(var.sg_ingress_rules)
  from_port                = var.sg_ingress_rules[count.index].from_port
  to_port                  = var.sg_ingress_rules[count.index].to_port
  referenced_security_group_id  = var.sg_ingress_rules[count.index].source_security_group_id
  ip_protocol              = var.sg_ingress_rules[count.index].ip_protocol
}
