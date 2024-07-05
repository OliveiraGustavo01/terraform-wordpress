resource "random_password" "db_password" {
  length           = 12
  upper            = true
  lower            = true
  numeric          = true
  override_special = "%&*()-_=+[]{}<>:?"
}


data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

data "aws_kms_key" "secrets" {
  key_id = "alias/aws/secretsmanager"
}


resource "aws_secretsmanager_secret" "wordpress" {
  name_prefix = "/rds/secret/${var.identifier}"
  description = "Secrets for ECS Wordpress"
  kms_key_id  = data.aws_kms_key.secrets.id
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "wordpress" {
  secret_id = aws_secretsmanager_secret.wordpress.id
  secret_string = jsonencode({
    WORDPRESS_DB_HOST     = aws_rds_cluster.wordpress.endpoint
    WORDPRESS_DB_USER     = var.master_username
    WORDPRESS_DB_PASSWORD = random_password.db_password.result
    WORDPRESS_DB_NAME     = var.database_name
  })
}
resource "aws_rds_cluster" "wordpress" {
  engine                                = var.engine
  engine_version                        = var.engine_version
  storage_encrypted                     = var.storage_encrypted
  kms_key_id                            = data.aws_kms_key.rds.arn
  availability_zones                    = var.availability_zones
  cluster_identifier                    = var.identifier
  database_name                         = var.database_name
  master_username                       = var.master_username
  master_password                       = random_password.db_password.result
  skip_final_snapshot                   = true
  vpc_security_group_ids                = [aws_security_group.rds_cluster.id]
  db_subnet_group_name                  = aws_db_subnet_group.rds_subnet_group.name
  network_type                          = "IPV4"
  apply_immediately                     = var.apply_immediately
  deletion_protection                   = var.deletion_protection
  backup_retention_period      = var.backup_retention_period
  preferred_maintenance_window = var.maintenance_window

  lifecycle {
    ignore_changes = [
      engine_version,
      availability_zones
    ]
  }
}


resource "aws_rds_cluster_instance" "wordpress" {
  publicly_accessible  = false
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = var.identifier
  cluster_identifier   = aws_rds_cluster.wordpress.id
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  apply_immediately    = var.apply_immediately
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = data.aws_kms_key.rds.arn
  performance_insights_retention_period = var.performance_insights_retention_period
  preferred_maintenance_window = var.maintenance_window

 lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB WordPress Subnet Group"
  }
}

resource "aws_security_group" "rds_cluster" {
  # count       = length(var.rds_cluster_security_group_ids) == 0 ? 1 : 0
  name        = "wordpress-rds-security_group"
  description = "wordpress to rds service"
  vpc_id      = data.aws_vpc.vpc.id
}
resource "aws_security_group_rule" "lb_service_ingress_https" {
  # count             = length(var.lb_security_group_ids) == 0 ? 1 : 0
  type              = "ingress"
  description       = "http"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_cluster.id
}

resource "aws_security_group_rule" "lb_service_egress_http" {
  # count                    = length(var.lb_security_group_ids) == 0 ? 1 : 0
  type                     = "egress"
  description              = "http"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.source_security_group_id
  security_group_id        = aws_security_group.rds_cluster.id
}
