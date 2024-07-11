/* Provider variable */
variable "aws_region" {
  description = "The AWS region to use for the project"
  type        = string
  default     = "eu-north-1"
}

/* Networking variables */
variable "vpc_cidr_block" {
  description = "CIDR range/block for the main VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "vpc_name" {
  description = "Name of the main VPC"
  type        = string
  default     = "JenkinsVPC"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "is_public_subnet_public" {
  description = "If instances in this subnet should get public IP"
  type        = bool
  default     = true
}

variable "public_subnet_name" {
  description = "Name assigned to the public subnet"
  type        = string
  default     = "FlaskSubnet"
}

variable "internet_gateway_name" {
  description = "Name assigned to the internet gateway"
  type        = string
  default     = "FlaskIGW"
}

variable "public_subnet_routing_table_name" {
  description = "Name assigned to the public subnet routing table"
  type        = string
  default     = "Public Subnet Routing Table"
}

variable "security_group_name" {
  description = "Name assigned to the Flask security group"
  type        = string
  default     = "FlaskSG"
}

/* App related variables */
variable "flask_http_port" {
  description = "The port Flask App will use for web traffic"
  type        = number
  default     = 80
}

# variable "ssh_port" {
#   description = "The port for SSH connections"
#   type        = number
#   default     = 22
# }

/* ECS/Fargate related variables */
variable "ecr_repo_name" {
  description = "Name of the ECR repo"
  type        = string
  default     = "flask-cicd"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "flask-ecs-cluster"
}


variable "task_family_name" {
  description = "Name of the family of the app task"
  type        = string
  default     = "flask_from_jenkins"
}

variable "container_resources" {
  type = object({
    cpu = number # CPU units where 1024 equals 1 vCPU
    ram = number # Ram in MB
  })
  description = (
  "Resources required for the container in CPU units and RAM")
  default = {
    cpu = 256 # 0.25 vCPU
    ram = 512 # 512 MB
  }
}

variable "task_container_name" {
  description = "Docker name of the container (not image)"
  type        = string
  default     = "flask_container"
}

variable "flask_environment_setting" {
  description = <<-EOF
    Container environment variable that chooses flask environment setting.
    Possible options are: development, production and testing.
    This choice has security implications.
  EOF
  type        = string
  default     = "production" # Using production to enhance security
}

variable "task_execution_role_name" {
  description = (
  "Name of the IAM role that gives the task execution privileges.")
  type    = string
  default = "ecsTaskExecutionRole"
}
