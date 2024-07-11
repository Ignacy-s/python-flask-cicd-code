# Pin dependencies to silence the linter
terraform {
  required_version = ">= 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.57.0"
    }
  }
}

/* Provider Definition */
provider "aws" {
  region = var.aws_region
}

# Needed to fetch the account ID
data "aws_caller_identity" "current" {}

# Declare the ECR repository we are going to use
data "aws_ecr_repository" "ecr_repo" {
  # ECR repository defined in another Terraform file
  name = var.ecr_repo_name
}

# Define an ECS cluster for our app
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

# Declare task definition for our deployment
resource "aws_ecs_task_definition" "flask_task" {
  family = var.task_family_name
  # operatingSystemFamily required when using Fargate
  runtime_platform { operating_system_family = "LINUX" }
  # awsvpc is the only option for Fargate
  network_mode = "awsvpc"
  # To use Fargate as the launch type
  requires_compatibilities = ["FARGATE"]

  # Hardware requirements
  cpu    = var.container_resources.cpu
  memory = var.container_resources.ram

  # ARN of the IAM role to allow the ECS Task call AWS API
  execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
  # Used container
  container_definitions = jsonencode([{
    name = var.task_container_name
    # image - that's the form we use when running containers using
    # the docker command
    #"image": ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${REPO}
    image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repo_name}"
    # TODO: Find a way to split this string into multiple lines.
    cpu       = var.container_resources.cpu
    memory    = var.container_resources.ram
    essential = true
    portMappings = [{
      containerPort = var.flask_http_port
      hostPort      = var.flask_http_port
      protocol      = "tcp"
    }]
    environment = [{
      name  = "FLASK_ENV"
      value = var.flask_environment_setting
    }]
  }])
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = var.task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = (
  "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy")
}
