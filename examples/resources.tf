locals {
  subnets_public_ids  = ["subnet-XXXXXXXXXXXXX", "subnet-XXXXXXXXXX"]
  subnets_private_ids = ["subnet-XXXXXXXXXXX", "subnet-XXXXXXXXXXXX"]
  vpc_name            = ""
  vpc_id	      = ""
  domain              = ""
}

module "wordpress" {
  source                  = "./modules/amazon_ecs/"
  ecs_cluster_name        = "wordpress-prd"
  lb_name                 = "wordpress-prd"
  ecs_service_subnet_ids  = local.subnets_private_ids
  lb_subnet_ids           = local.subnets_public_ids
  vpc_name                = local.vpc_name
  domain                  = local.domain
  secret_name             = module.database.secret
  rds_security_groups_ids = module.database.rds_cluster_security_group_ids
  redis_security_groups_ids = module.REDIS-SG.security_group_id
}

module "database" {
  source                   = "./modules/amazon_database/"
  availability_zones       = ["us-east-1a", "us-east-1b"]
  identifier               = "wordpress-production"
  engine                   = "aurora-mysql"
  engine_version           = "8.0.mysql_aurora.3.04.2"
  instance_class           = "db.t4g.large"
  database_name            = "wordpress_prod"
  master_username          = "root"
  maintenance_window       = "Mon:00:00-Mon:03:00"
  deletion_protection      = true
  subnet_ids               = local.subnets_private_ids
  vpc_name                 = local.vpc_name
  source_security_group_id = module.wordpress.ecs_service_security_grop_ids
}


module "cloudfront" {
  source               = "./modules/amazon_cloudfront"
  target_origin_id     = module.wordpress.lb_dns_name
  web_acl_id           = module.waf.web_acl_arn
  domain               = local.domain
  aliases              = [local.domain]
}

module "waf" {
  source       = "./modules/amazon_waf" #não-editavel
  web_acl_name = "Wordpress_Application_Firewall"
  resource     = module.cloudfront.arn
}

module "REDIS-SG" {
  source = "./modules/amazon_securitygroup"
  name   = "redis-security-wordpress"
  vpc_id = local.vpc_id
  sg_ingress_rules = [{
    from_port   = 6379
    to_port     = 6379
    ip_protocol = "tcp"
    source_security_group_id   = module.wordpress.ecs_service_security_grop_ids
    description = "Access From Subnet ecs"
    }
  ]
  sg_egress_rules = [{
    from_port   = -1
    to_port     = -1
    ip_protocol = "-1"
    source_security_group_id   = module.wordpress.ecs_service_security_grop_ids
    description = "egress-rule"
    }
  ]
}

module "elasticache" {
  source = "./modules/amazon_elasticache/"

  replication_group_id          = "Hub-Redis-wordpress"
  replication_group_description = "Redis service"
  engine                        = "redis"
  engine_version                = "7.1"
  family                        = "redis7"
  subnet_ids                    = local.subnets_private_ids
  security_group_ids            = [module.REDIS-SG.security_group_id]
  node_type                     = "cache.t4g.small"
  number_cache_clusters         = "1"
  log_format                    = "text"
  log_type                      = "slow-log"
  tags = {
    "Darede_Team"  = "DevOps"
  }
}
