data "aws_iam_role" "task_ecs" {
  name = "ecsTaskExecutionRole"
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnet_ids" "subnets" {
  vpc_id = "${data.aws_vpc.default_vpc.id}"
}

# Create ECR repository with the module
module "ecr_repository" {
  source             = "./modules/ecr"
  repository_name    = "waycab"
  image_scanning     = true
  image_tag_mutability = "IMMUTABLE"
  tags = {
    Environment = "dev"
    Project     = "tp-challenge"
  }
}
