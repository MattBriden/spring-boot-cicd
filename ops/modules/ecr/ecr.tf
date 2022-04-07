resource "aws_ecr_repository" "springboot_repo" {
  name                 = "springboot-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
