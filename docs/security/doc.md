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
| [aws_security_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"sg created by terraform"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `null` | no |
| <a name="input_sg_egress_rules"></a> [sg\_egress\_rules](#input\_sg\_egress\_rules) | egress rules | <pre>list(object({<br>    from_port                = number<br>    to_port                  = number<br>    ip_protocol              = string<br>    source_security_group_id = string<br>    description              = string<br>  }))</pre> | n/a | yes |
| <a name="input_sg_ingress_rules"></a> [sg\_ingress\_rules](#input\_sg\_ingress\_rules) | ingress rules | <pre>list(object({<br>    from_port                = number<br>    to_port                  = number<br>    ip_protocol              = string<br>    source_security_group_id = string<br>    description              = string<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | tags for services | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
