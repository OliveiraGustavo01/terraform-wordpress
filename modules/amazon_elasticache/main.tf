resource "aws_elasticache_subnet_group" "shared" {
  name       = "${var.replication_group_id}-subnet-group"
  subnet_ids = var.subnet_ids
  tags_all   = var.tags
  tags	     = var.tags
}
resource "aws_elasticache_replication_group" "main" {
  automatic_failover_enabled    = var.automatic_failover_enabled
  subnet_group_name             = aws_elasticache_subnet_group.shared.id
  security_group_ids            = var.security_group_ids
  replication_group_id          = var.replication_group_id
  replication_group_description = var.replication_group_description
  node_type                     = var.node_type
  number_cache_clusters         = var.number_cache_clusters
  parameter_group_name          = aws_elasticache_parameter_group.default.id
  engine                        = var.engine
  engine_version                = var.engine_version
  multi_az_enabled              = var.multi_az_enabled
  at_rest_encryption_enabled    = true
  port                          = var.port

  transit_encryption_enabled	= var.transit_encryption_enabled
  auth_token			= var.auth_token

  apply_immediately 		= var.apply_immediately
  maintenance_window            = var.redis_maintenance_window	

  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit

  lifecycle {
    ignore_changes = [number_cache_clusters]
  }
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.example.name
    destination_type = "cloudwatch-logs"
    log_format       = var.log_format
    log_type         = var.log_type
  }

  tags = var.tags
}

resource "aws_elasticache_parameter_group" "default" {
  name   = var.replication_group_id
  family = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }
}
resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/elasticache/${var.replication_group_id}/"
  retention_in_days = 7
  tags              = var.tags
  # ... potentially other configuration ...
}
