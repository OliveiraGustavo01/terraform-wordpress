data "aws_acm_certificate" "domain" {
  domain      = var.domain
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

resource "aws_kms_key" "wordpress" {
  description             = "KMS Key used to encrypt Wordpress related resources"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms.json
  tags                    = var.tags
}

resource "aws_kms_alias" "wordpress" {
  name          = "alias/wordpress"
  target_key_id = aws_kms_key.wordpress.id
}
resource "aws_efs_file_system" "wordpress" {
  creation_token = "wordpress"
  encrypted      = true
  kms_key_id     = aws_kms_key.wordpress.arn
  tags           = var.tags
}

resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.wordpress.id

  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "wordpress" {
  count           = length(var.ecs_service_subnet_ids)
  file_system_id  = aws_efs_file_system.wordpress.id
  subnet_id       = var.ecs_service_subnet_ids[count.index]
  security_groups = [aws_security_group.efs_service.id]
}

resource "aws_efs_access_point" "wordpress" {
  file_system_id = aws_efs_file_system.wordpress.id
  posix_user {
    gid = 33
    uid = 33
  }
  root_directory {
    path = "/wordpress"
    creation_info {
      owner_gid   = 33
      owner_uid   = 33
      permissions = 755
    }
  }
}

resource "aws_cloudwatch_log_group" "wordpress" {
  name              = format("%s-%s", var.ecs_cloudwatch_logs_group_name, var.ecs_cluster_name)
  retention_in_days = 14
  kms_key_id        = aws_kms_key.wordpress.arn
  tags              = var.tags
}

resource "aws_ecs_cluster" "wordpress" {
  name = var.ecs_cluster_name
  tags = var.tags
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "wordpress" {
  family = var.ecs_task_definition_family
  container_definitions = templatefile(
    "${path.module}/assests/wordpress.tpl",
    {
      ecs_service_container_name = var.ecs_service_container_name
      aws_region                 = data.aws_region.current.name
      aws_logs_group             = aws_cloudwatch_log_group.wordpress.name
      aws_account_id             = data.aws_caller_identity.current.account_id
      secret_name                = var.secret_name
      cloudwatch_log_group       = format("%s-%s", var.ecs_cloudwatch_logs_group_name, var.ecs_cluster_name)
    }
  )
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_definition_cpu
  memory                   = var.ecs_task_definition_memory
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  volume {
    name = "wordpress"
    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.wordpress.id
      root_directory     = "/"
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.wordpress.id
      }
    }
  }
  tags = var.tags
}

resource "aws_ecs_service" "wordpress" {
  name             = var.ecs_service_name
  cluster          = aws_ecs_cluster.wordpress.arn
  task_definition  = aws_ecs_task_definition.wordpress.arn
  desired_count    = var.ecs_service_desired_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  propagate_tags   = "SERVICE"
  network_configuration {
    subnets          = var.ecs_service_subnet_ids
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = var.ecs_service_assign_public_ip
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.wordpress_http.arn
    container_name   = var.ecs_service_container_name
    container_port   = "80"
  }
  tags = var.tags
}

resource "aws_lb" "wordpress" {
  name               = var.lb_name
  internal           = var.lb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_service.id]
  subnets            = var.lb_subnet_ids
  tags               = var.tags
}

resource "aws_lb_listener" "wordpress_http" {
  load_balancer_arn = aws_lb.wordpress.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_http.arn
  }
}

resource "aws_lb_listener" "wordpress_https" {
  count             = var.lb_listener_enable_ssl ? 1 : 0
  certificate_arn   = data.aws_acm_certificate.domain.id
  load_balancer_arn = aws_lb.wordpress.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.lb_listener_ssl_policy
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_http.arn
  }
}

resource "aws_lb_target_group" "wordpress_http" {
  name        = var.lb_target_group_http
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    matcher = "200-499"
  }
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = true
  }
  tags = var.tags
}

##Security Groups

resource "aws_security_group" "efs_service" {
  # count       = length(var.efs_service_security_group_ids) == 0 ? 1 : 0
  name        = "wordpress-efs-service"
  description = "wordpress-efs-service"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_security_group_rule" "efs_service_ingress_nfs_tcp" {
  # count                    = length(var.efs_service_security_group_ids) == 0 ? 1 : 0
  type                     = "ingress"
  description              = "nfs from efs"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_service.id
  security_group_id        = aws_security_group.efs_service.id
}


resource "aws_security_group" "ecs_service" {
  # count       = length(var.ecs_service_security_group_ids) == 0 ? 1 : 0
  name        = "wordpress-ecs-service"
  description = "wordpress ecs service"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_security_group_rule" "ecs_service_ingress_http" {
  # count                    = length(var.ecs_service_security_group_ids) == 0 ? 1 : 0
  type                     = "ingress"
  description              = "http from load balancer"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_service.id
  security_group_id        = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_ingress_https" {
  # count                    = length(var.ecs_service_security_grop_ids) == 0 ? 1 : 0
  type                     = "ingress"
  description              = "https from load balancer"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_service.id
  security_group_id        = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_egress_http" {
  # count             = length(var.ecs_service_security_group_ids) == 0 ? 1 : 0
  type              = "egress"
  description       = "http to internet"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_egress_https" {
  # count             = length(var.ecs_service_security_group_ids) == 0 ? 1 : 0
  type              = "egress"
  description       = "https to internet"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_service.id
}
resource "aws_security_group_rule" "ecs_service_egress_efs_tcp" {
  # count                    = length(var.ecs_service_security_group_ids) == 0 ? 1 : 0
  type                     = "egress"
  description              = "efs"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.efs_service.id
  security_group_id        = aws_security_group.ecs_service.id
}

resource "aws_security_group" "lb_service" {
  # count       = length(var.lb_security_group_ids) == 0 ? 1 : 0
  name        = "wordpress-alb-service"
  description = "wordpress to alb service"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_security_group_rule" "lb_service_ingress_http" {
  # count             = length(var.lb_security_group_ids) == 0 ? 1 : 0
  type              = "ingress"
  description       = "http"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_service.id
}

resource "aws_security_group_rule" "lb_service_ingress_https" {
  # count             = length(var.lb_security_group_ids) == 0 ? 1 : 0
  type              = "ingress"
  description       = "http"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_service.id
}

resource "aws_security_group_rule" "lb_service_egress_http" {
  # count                    = length(var.lb_security_group_ids) == 0 ? 1 : 0
  type                     = "egress"
  description              = "http"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_service.id
  security_group_id        = aws_security_group.lb_service.id
}

resource "aws_security_group_rule" "lb_service_egress_https" {
  # count                    = length(var.lb_security_group_ids) == 0 ? 1 : 0
  type                     = "egress"
  description              = "https"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_service.id
  security_group_id        = aws_security_group.lb_service.id
}

resource "aws_security_group_rule" "ecs_service_egress_rds" {
  # count             = length(var.ecs_service_security_group_ids) == 0 ? 1 : 0
  type                     = "egress"
  description              = "mysql"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.rds_security_groups_ids
  security_group_id        = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_ingress_rds" {
  # count             = length(var.ecs_service_security_group_ids) == 0 ? 1 : 0
  type                     = "ingress"
  description              = "mysql"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.rds_security_groups_ids
  security_group_id        = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_ingress_redis" {
  # count             = length(var.ecs_service_security_group_ids) == 0 ? 1 : 0
  type                     = "ingress"
  description              = "redis"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = var.redis_security_groups_ids
  security_group_id        = aws_security_group.ecs_service.id
}
resource "aws_security_group_rule" "ecs_service_egress_redis" {
  # count             = length(var.ecs_service_security_group_ids) == 0 ? 1 : 0
  type                     = "egress"
  description              = "redis"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = var.redis_security_groups_ids
  security_group_id        = aws_security_group.ecs_service.id
}
#resource "aws_appautoscaling_target" "wp_target" {
#  max_capacity       = 4
#  min_capacity       = 2
#  resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
#  scalable_dimension = "ecs:service:DesiredCount"
#  service_namespace  = "ecs"
#}
#
#resource "aws_appautoscaling_policy" "wp_to_memory" { #policy para escalar conforme o aumento de memória
#  name               = "wp-scale-memory"
#  policy_type        = "TargetTrackingScaling"
#  resource_id        = aws_appautoscaling_target.wp_target.resource_id
#  scalable_dimension = aws_appautoscaling_target.wp_target.scalable_dimension
#  service_namespace  = aws_appautoscaling_target.wp_target.service_namespace
#
#  target_tracking_scaling_policy_configuration {
#    predefined_metric_specification {
#      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
#    }
#
#    target_value = var.target_value_Memory
#  }
#}

#resource "aws_appautoscaling_policy" "wp_to_cpu" {
#  name               = "wp-to-cpu"
#  policy_type        = "TargetTrackingScaling"
#  resource_id        = aws_appautoscaling_target.wp_target.resource_id
#  scalable_dimension = aws_appautoscaling_target.wp_target.scalable_dimension
#  service_namespace  = aws_appautoscaling_target.wp_target.service_namespace
#
#  target_tracking_scaling_policy_configuration {
#    predefined_metric_specification {
#      predefined_metric_type = "ECSServiceAverageCPUUtilization"
#    }
#
#    target_value = var.target_value_CPU
#  }
#}
