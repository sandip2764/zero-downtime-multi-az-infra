
# ECR

resource "aws_ecr_repository" "app_repo" {
  name                 = "multi-az-zero-downtime-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "multi-az-zero-downtime-ecr"
  }
}
