variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "cluster_name" {
  type        = string
  default     = "default"
  description = "ECS cluster name"
}

variable "instance_type" {
  type        = string
  default     = "t3a.micro"
  description = "ECS container-instance type"
}

variable "ami_id" {
  type        = string
  default     = null
  description = "AMI ID for ECS container-instances"
}

variable "shared_storage_path_prefix" {
  type        = string
  default     = "/mnt/fsx"
  description = "Filesystem path prefix for FSx shared stores; each SFTP user will have its own mount-point under this path"
}

variable "instance_profile" {
  type        = string
  default     = "ecs-instance"
  description = "ECS container-instance IAM profile name; must be an existing instance profile"
}

variable "ssh_key_name" {
  type        = string
  default     = "ecs-ssh"
  description = "ECS container-instance SSH key-pair name; must be an existing key-pair"
}

variable "log_retention_in_days" {
  type        = number
  default     = 30
  description = "CloudWatch Logs retention in days"
}

variable "execution_role_arn" {
  type        = string
  default     = null
  description = "ECS 'Task Execution Role' ARN; overrides `execution_role_name`"
}

variable "task_role_arn" {
  type        = string
  default     = null
  description = "ECS 'Task Role' ARN; overrides `task_role_name`"
}

variable "task_role_name" {
  type        = string
  default     = "ecs-task"
  description = "ECS 'Task Role' name; overriden by `task_role_arn`"
}

variable "execution_role_name" {
  type        = string
  default     = "ecs-execution"
  description = "ECS 'Task Execution Role' name; overriden by `execution_role_arn`"
}

variable "cidr_whitelist" {
  type        = list(string)
  default     = null
  description = "CIDR whitelist for allowed container-instance ingress traffic for SSH and SFTP"
}

variable "sftp_host_port" {
  type        = number
  default     = 2222
  description = "Host port for SFTP access"
}

variable "sftp_task_port" {
  type        = number
  default     = 22
  description = "ECS task port for SFTP access"
}

/**
* SFTP configuration:
*
* The sftp server configurations and SSH keys are injected from AWS SSM Parameter Store. Keys must be  
* created externally for SFTP users and for the SFTP host, encoded as base64 values and stored in SSM parameters.
* 
* Parameter names are used as input for the Terraform configurations, through TF vars.
* 
* Parameter names are built from TF vars in the form:
* `<prefix><suffix>[<sftp user>]`
*
* Prefix and suffix values must start with `/` and must not end with `/`; or can be set to an empty string.
*
* The prefix is given by the `sftp_ssm_param_prefix` var.
*
* The suffixes are:
*
* - `sftp_ssm_param_user_pub_key`: precedes user public keys, one key per user (e.g. `/sftp/user/public-key/machine-user`)
* - `sftp_ssm_param_host_pub_key`: host public key (default: `/sftp/host/public-key`)
* - `sftp_ssm_param_host_priv_key`: host private key (default: `/sftp/host/private-key`)
*  
* The sftp container will also mount the `/etc/sftp/users.conf` file from an SSM parameter 
* (default: `/sftp/config/users-conf`), given by the suffix `sftp_ssm_param_config_users_conf`. 
*  
* The 'users-conf' parameter is created from the template: `./tpl/users.conf.tftpl`
*  
*/
variable "sftp_ssm_param_prefix" {
  type        = string
  default     = "/sftp"
  description = "Prefix for SSM parameters used for SFTP configuration"
}

variable "sftp_ssm_param_user_pub_key" {
  type        = string
  default     = "/user/public-key"
  description = "SSM param path for users' public keys"
}

variable "sftp_ssm_param_host_pub_key" {
  type        = string
  default     = "/host/public-key"
  description = "SSM param path for the host public key"
}

variable "sftp_ssm_param_host_priv_key" {
  type        = string
  default     = "/host/private-key"
  description = "SSM param path for the host private key"
}

/**
* `config/users-conf` SSM parameter is created from `tpl/users.conf.tpl`
*/
variable "sftp_ssm_param_config_users_conf" {
  type        = string
  default     = "/config/users-conf"
  description = "SSM param path for the `/etc/sftp/users.conf` file"
}

variable "sftp_uid_start" {
  type        = number
  default     = 1001
  description = "Starting Unix UID for SFTP users; will be incremented by 1 for each extra user"
}

variable "sftp_users" {
  type        = string
  description = "Comma-separated list of SFTP users to add"
}

variable "sftp_volume_name_storage" {
  type        = string
  default     = "sftp-storage"
  description = "SFTP storage-volumes name prefix; user names will be added as suffixes"
}

variable "sftp_volume_name_user" {
  type        = string
  default     = "sftp-user"
  description = "SFTP user-volumes name prefix; user names will be added as suffixes"
}

variable "sftp_volume_name_host" {
  type        = string
  default     = "sftp-host"
  description = "SFTP host-volume name"
}

variable "sftp_volume_name_config" {
  type        = string
  default     = "sftp-config"
  description = "SFTP config-volume name"
}

variable "sftp_volume_name_scripts" {
  type        = string
  default     = "sftp-scripts"
  description = "SFTP scripts-volume name"
}
