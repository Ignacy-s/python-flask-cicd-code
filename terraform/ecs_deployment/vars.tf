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
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the main VPC"
  type        = string
  default     = "JenkinsVPC"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "is_public_subnet_public" {
  description = "If instances in this subnet should get public IP"
  type        = bool
  default     = true
}

variable "public_subnet_name" {
  description = "Name assigned to the public subnet"
  type        = string
  default     = "JenkinsSubnet"
}

variable "internet_gateway_name" {
  description = "Name assigned to the internet gateway"
  type        = string
  default     = "JenkinsIGW"
}

variable "public_subnet_routing_table_name" {
  description = "Name assigned to the public subnet routing table"
  type        = string
  default     = "Public Subnet Routing Table"
}

variable "security_group_name" {
  description = "Name assigned to the Jenkin's security group"
  type        = string
  default     = "JenkinsSG"
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
variable "" {
  description = ""
  type        = 
  default     =
}
