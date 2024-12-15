resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_scanning_configuration {
    scan_on_push = var.image_scanning
  }
  image_tag_mutability = var.image_tag_mutability

  tags = var.tags
}