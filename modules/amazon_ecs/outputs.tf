output "efs_id" {
  value = aws_efs_file_system.wordpress.id
}

output "kms_key_id" {
  value = aws_kms_key.wordpress.id
}

output "kms_key_arn" {
  value = aws_kms_key.wordpress.arn
}

output "kms_key_alias" {
  value = aws_kms_alias.wordpress.name
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.wordpress.arn
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.wordpress.arn
}

output "ecs_task_definition_family" {
  value = aws_ecs_task_definition.wordpress.family
}

output "ecs_task_definition_revision" {
  value = aws_ecs_task_definition.wordpress.revision
}
output "ecs_service_id" {
  value = aws_ecs_service.wordpress.id
}

output "lb_dns_name" {
  value = aws_lb.wordpress.dns_name
}

output "ecs_service_security_grop_ids" {
  value = aws_security_group.ecs_service.id
}