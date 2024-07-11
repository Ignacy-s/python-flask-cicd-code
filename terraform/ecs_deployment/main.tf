provider "aws" {
  region = var.aws_region
}

data "aws_ecr_repository" "flask_cicd_repo" {
  # ECR repository defined in another Terraform file
  name   = "flask-cicd"
}

resource "aws_ecs_cluster" "flask_cicd_ecs_cluster" {
  name   = "flask-cicd-ecs-cluster"
}


