provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "flask_cicd_repo" {
  name                  = "flask-cicd"
  image_tag_mutability  = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
  force_delete          = true
}
