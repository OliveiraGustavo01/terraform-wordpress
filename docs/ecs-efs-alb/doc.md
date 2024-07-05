## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.wp_to_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.wp_to_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.wp_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_efs_access_point.wordpress_plugins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_access_point.wordpress_themes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_iam_policy.ecs_task_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_lb.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.wordpress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.wordpress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.wordpress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.efs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.lb_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ecs_service_egress_efs_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_service_egress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_service_egress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_service_egress_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_service_ingress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_service_ingress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_service_ingress_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.efs_service_ingress_nfs_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.lb_service_egress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.lb_service_egress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.lb_service_ingress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.lb_service_ingress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_acm_certificate.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ecs_task_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_task_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnet.ecs_service_subnet_ids](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | the DNS name to Wordpress Website - THE SAME THAT ACM ISSUED | `string` | n/a | yes |
| <a name="input_ecs_cloudwatch_logs_group_name"></a> [ecs\_cloudwatch\_logs\_group\_name](#input\_ecs\_cloudwatch\_logs\_group\_name) | Name of the Log Group where ECS logs should be written | `string` | `"/ecs/wordpress"` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name for the ECS cluster | `string` | `"wordpress_cluster"` | no |
| <a name="input_ecs_service_assign_public_ip"></a> [ecs\_service\_assign\_public\_ip](#input\_ecs\_service\_assign\_public\_ip) | Whether to assign a public IP to the task ENIs | `bool` | `false` | no |
| <a name="input_ecs_service_container_name"></a> [ecs\_service\_container\_name](#input\_ecs\_service\_container\_name) | Container name for the container definition and Target Group association | `string` | `"wordpress"` | no |
| <a name="input_ecs_service_desired_count"></a> [ecs\_service\_desired\_count](#input\_ecs\_service\_desired\_count) | Number of tasks to have running | `number` | `2` | no |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | Name for the ECS Service | `string` | `"wordpress"` | no |
| <a name="input_ecs_service_subnet_ids"></a> [ecs\_service\_subnet\_ids](#input\_ecs\_service\_subnet\_ids) | Subnet ids where ENIs are created for tasks | `list(string)` | n/a | yes |
| <a name="input_ecs_task_definition_cpu"></a> [ecs\_task\_definition\_cpu](#input\_ecs\_task\_definition\_cpu) | Number of CPU units reserved for the container in powers of 2 | `string` | `"1024"` | no |
| <a name="input_ecs_task_definition_family"></a> [ecs\_task\_definition\_family](#input\_ecs\_task\_definition\_family) | Specify a family for a task definition, which allows you to track multiple versions of the same task definition | `string` | `"wordpress-family"` | no |
| <a name="input_ecs_task_definition_memory"></a> [ecs\_task\_definition\_memory](#input\_ecs\_task\_definition\_memory) | Specify a family for a task definition, which allows you to track multiple versions of the same task definition | `string` | `"2048"` | no |
| <a name="input_lb_internal"></a> [lb\_internal](#input\_lb\_internal) | If the load balancer should be an internal load balancer | `bool` | `false` | no |
| <a name="input_lb_listener_enable_ssl"></a> [lb\_listener\_enable\_ssl](#input\_lb\_listener\_enable\_ssl) | Enable the SSL listener, if this is set the lb\_listener\_certificate\_arn must also be provided | `bool` | `true` | no |
| <a name="input_lb_listener_ssl_policy"></a> [lb\_listener\_ssl\_policy](#input\_lb\_listener\_ssl\_policy) | The SSL policy to apply to the HTTPS listener | `string` | `"ELBSecurityPolicy-TLS13-1-2-2021-06"` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | Name for the load balancer | `string` | `"wordpress"` | no |
| <a name="input_lb_subnet_ids"></a> [lb\_subnet\_ids](#input\_lb\_subnet\_ids) | Subnets where load balancer should be created | `list(string)` | n/a | yes |
| <a name="input_lb_target_group_http"></a> [lb\_target\_group\_http](#input\_lb\_target\_group\_http) | Name of the HTTP target group | `string` | `"wordpress-http"` | no |
| <a name="input_lb_target_group_https"></a> [lb\_target\_group\_https](#input\_lb\_target\_group\_https) | Name of the HTTPS target group | `string` | `"wordpress-https"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name to Policy created by ECS | `string` | `"wordpressPolicyEcs"` | no |
| <a name="input_rds_security_groups_ids"></a> [rds\_security\_groups\_ids](#input\_rds\_security\_groups\_ids) | n/a | `any` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name to Role created by ECS | `string` | `"wordpressRoleEcs"` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to provide to the resources created | `map(string)` | `{}` | no |
| <a name="input_target_value_CPU"></a> [target\_value\_CPU](#input\_target\_value\_CPU) | n/a | `number` | `50` | no |
| <a name="input_target_value_Memory"></a> [target\_value\_Memory](#input\_target\_value\_Memory) | n/a | `number` | `50` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Unique name of the VPC that will be outfitted with Routes and Network ACLs | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | n/a |
| <a name="output_ecs_service_id"></a> [ecs\_service\_id](#output\_ecs\_service\_id) | n/a |
| <a name="output_ecs_service_security_grop_ids"></a> [ecs\_service\_security\_grop\_ids](#output\_ecs\_service\_security\_grop\_ids) | n/a |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | n/a |
| <a name="output_ecs_task_definition_family"></a> [ecs\_task\_definition\_family](#output\_ecs\_task\_definition\_family) | n/a |
| <a name="output_ecs_task_definition_revision"></a> [ecs\_task\_definition\_revision](#output\_ecs\_task\_definition\_revision) | n/a |
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | n/a |
| <a name="output_kms_key_alias"></a> [kms\_key\_alias](#output\_kms\_key\_alias) | n/a |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | n/a |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | n/a |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | n/a |
