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
| [aws_cloudwatch_log_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_elasticache_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.shared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false. | `bool` | `true` | no |
| <a name="input_auth_token"></a> [auth\_token](#input\_auth\_token) | The password used to access a password protected server. | `string` | `null` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | n/a | `any` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | n/a | `any` | n/a | yes |
| <a name="input_family"></a> [family](#input\_family) | n/a | `any` | n/a | yes |
| <a name="input_log_format"></a> [log\_format](#input\_log\_format) | n/a | `any` | n/a | yes |
| <a name="input_log_type"></a> [log\_type](#input\_log\_type) | n/a | `any` | n/a | yes |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | n/a | `any` | n/a | yes |
| <a name="input_number_cache_clusters"></a> [number\_cache\_clusters](#input\_number\_cache\_clusters) | n/a | `any` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | additional parameters modifyed in parameter group | `list(map(any))` | `[]` | no |
| <a name="input_port"></a> [port](#input\_port) | n/a | `number` | `6379` | no |
| <a name="input_redis_maintenance_window"></a> [redis\_maintenance\_window](#input\_redis\_maintenance\_window) | format is ddd:hh24:mi-ddd:hh24:mi | `string` | `"sat:08:00-sat:09:00"` | no |
| <a name="input_redis_parameters"></a> [redis\_parameters](#input\_redis\_parameters) | additional parameters modifyed in parameter group | `list(map(any))` | `[]` | no |
| <a name="input_replication_group_description"></a> [replication\_group\_description](#input\_replication\_group\_description) | n/a | `any` | n/a | yes |
| <a name="input_replication_group_id"></a> [replication\_group\_id](#input\_replication\_group\_id) | n/a | `any` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of Security Group ID's to allow access to. | `list(string)` | `[]` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. | `number` | `5` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period | `string` | `"06:30-07:30"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of VPC Subnet IDs for the cache subnet group | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | Whether to enable encryption in transit. Requires 3.2.6 or >=4.0 redis\_version | `bool` | `false` | no |

## Outputs

No outputs.
