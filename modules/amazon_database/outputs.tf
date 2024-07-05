output "secret" {
  description = "AWS SecretManager Secret resource"
  value       = aws_secretsmanager_secret.wordpress.name
}

output "rds_cluster_security_group_ids" {

  description = "RDS security group ID"
  value       = aws_security_group.rds_cluster.id
}