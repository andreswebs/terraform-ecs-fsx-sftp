# terraform-aws-ecs-fsx-sftp

[//]: # (BEGIN_TF_DOCS)
Deploys an ECS cluster running an SFTP service as a daemon.

## Usage

Example:

```hcl
module "sftp" {
  source         = "github.com/andreswebs/terraform-aws-ecs-fsx-sftp"
  cluster_name   = "example"
  vpc_id         = var.vpc_id
  subnet_ids     = var.subnet_ids
  ami_id         = var.ami_id
  cidr_whitelist = [var.corp_vpn]
  sftp_users     = "user-1,user-2,user-3"
}
```



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID for ECS container-instances | `string` | `null` | no |
| <a name="input_cidr_whitelist"></a> [cidr\_whitelist](#input\_cidr\_whitelist) | CIDR whitelist for allowed container-instance ingress traffic for SSH and SFTP | `list(string)` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | ECS cluster name | `string` | `"default"` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | ECS 'Task Execution Role' ARN; overrides `execution_role_name` | `string` | `null` | no |
| <a name="input_execution_role_name"></a> [execution\_role\_name](#input\_execution\_role\_name) | ECS 'Task Execution Role' name; overriden by `execution_role_arn` | `string` | `"ecs-execution"` | no |
| <a name="input_instance_profile"></a> [instance\_profile](#input\_instance\_profile) | ECS container-instance IAM profile name; must be an existing instance profile | `string` | `"ecs-instance"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | ECS container-instance type | `string` | `"t3a.micro"` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | CloudWatch Logs retention in days | `number` | `30` | no |
| <a name="input_sftp_host_port"></a> [sftp\_host\_port](#input\_sftp\_host\_port) | Host port for SFTP access | `number` | `2222` | no |
| <a name="input_sftp_ssm_param_config_users_conf"></a> [sftp\_ssm\_param\_config\_users\_conf](#input\_sftp\_ssm\_param\_config\_users\_conf) | SSM param path for the `/etc/sftp/users.conf` file | `string` | `"/config/users-conf"` | no |
| <a name="input_sftp_ssm_param_host_priv_key"></a> [sftp\_ssm\_param\_host\_priv\_key](#input\_sftp\_ssm\_param\_host\_priv\_key) | SSM param path for the host private key | `string` | `"/host/private-key"` | no |
| <a name="input_sftp_ssm_param_host_pub_key"></a> [sftp\_ssm\_param\_host\_pub\_key](#input\_sftp\_ssm\_param\_host\_pub\_key) | SSM param path for the host public key | `string` | `"/host/public-key"` | no |
| <a name="input_sftp_ssm_param_prefix"></a> [sftp\_ssm\_param\_prefix](#input\_sftp\_ssm\_param\_prefix) | Prefix for SSM parameters used for SFTP configuration | `string` | `"/sftp"` | no |
| <a name="input_sftp_ssm_param_user_pub_key"></a> [sftp\_ssm\_param\_user\_pub\_key](#input\_sftp\_ssm\_param\_user\_pub\_key) | SSM param path for users' public keys | `string` | `"/user/public-key"` | no |
| <a name="input_sftp_task_port"></a> [sftp\_task\_port](#input\_sftp\_task\_port) | ECS task port for SFTP access | `number` | `22` | no |
| <a name="input_sftp_uid_start"></a> [sftp\_uid\_start](#input\_sftp\_uid\_start) | Starting Unix UID for SFTP users; will be incremented by 1 for each extra user | `number` | `1001` | no |
| <a name="input_sftp_users"></a> [sftp\_users](#input\_sftp\_users) | Comma-separated list of SFTP users to add | `string` | n/a | yes |
| <a name="input_sftp_volume_name_config"></a> [sftp\_volume\_name\_config](#input\_sftp\_volume\_name\_config) | SFTP config-volume name | `string` | `"sftp-config"` | no |
| <a name="input_sftp_volume_name_host"></a> [sftp\_volume\_name\_host](#input\_sftp\_volume\_name\_host) | SFTP host-volume name | `string` | `"sftp-host"` | no |
| <a name="input_sftp_volume_name_scripts"></a> [sftp\_volume\_name\_scripts](#input\_sftp\_volume\_name\_scripts) | SFTP scripts-volume name | `string` | `"sftp-scripts"` | no |
| <a name="input_sftp_volume_name_storage"></a> [sftp\_volume\_name\_storage](#input\_sftp\_volume\_name\_storage) | SFTP storage-volumes name prefix; user names will be added as suffixes | `string` | `"sftp-storage"` | no |
| <a name="input_sftp_volume_name_user"></a> [sftp\_volume\_name\_user](#input\_sftp\_volume\_name\_user) | SFTP user-volumes name prefix; user names will be added as suffixes | `string` | `"sftp-user"` | no |
| <a name="input_shared_storage_path_prefix"></a> [shared\_storage\_path\_prefix](#input\_shared\_storage\_path\_prefix) | Filesystem path prefix for FSx shared stores; each SFTP user will have its own mount-point under this path | `string` | `"/mnt/fsx"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | ECS container-instance SSH key-pair name; must be an existing key-pair | `string` | `"ecs-ssh"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs | `list(string)` | n/a | yes |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | ECS 'Task Role' ARN; overrides `task_role_name` | `string` | `null` | no |
| <a name="input_task_role_name"></a> [task\_role\_name](#input\_task\_role\_name) | ECS 'Task Role' name; overriden by `task_role_arn` | `string` | `"ecs-task"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam"></a> [iam](#module\_iam) | ./modules/iam | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster"></a> [ecs\_cluster](#output\_ecs\_cluster) | n/a |
| <a name="output_launch_template"></a> [launch\_template](#output\_launch\_template) | n/a |
| <a name="output_task_definition"></a> [task\_definition](#output\_task\_definition) | n/a |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.50.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.50.0 |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_capacity_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_capacity_provider) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.sftp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.sftp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sftp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ssm_parameter.sftp_config_users_conf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ami.ecs_ami_latest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

[//]: # (END_TF_DOCS)

## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)

## License

This project is licensed under the [Unlicense](UNLICENSE.md).
