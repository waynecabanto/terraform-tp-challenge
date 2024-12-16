# Create ECR repository with the module
module "ecr_repository" {
  source                      = "./modules/ecr"
  repository_name             = "waycab/hellopy"
  image_scanning              = true
  image_tag_mutability        = "MUTABLE"
  # tags = {
  #   Environment = "dev"
  #   Project     = "tp-challenge"
  # }
}

# Create public and private subnets, route tables, nat and internet gateways, elastic ips.
module "network" {
  source                     = "./modules/vpc/public-private-subnet" 
  vpc_id                     = data.aws_vpc.default_vpc.id
  public_cidr_block          = "172.31.48.0/24"
  private_cidr_block         = "172.31.64.0/24"
  public_availability_zone   = "eu-west-1a"
  private_availability_zone  = "eu-west-1b"
  nat_gw_name                = "waycab-natgw"
  igw_name                   = "waycab-igw"
  public_subnet_name         = "waycab-public-subnet"
  private_subnet_name        = "waycab-private-subnet"
  internet_gateway_id        = data.aws_internet_gateway.vpc_igw.id
  private_route_table_name   = "waycab-private-rt"
  public_route_table_name    = "waycab-public-rt"
}

# Create ECS Cluster
module "ecs_cluster" {
  source                     = "./modules/ecs/cluster"
  ecs_cluster_name           = "waycab-ecs-cluster"
}

# Create Fargate on ECS inside the private subnet to avoid exposing sensitive data to the internet
module "ecs_fargate" {
  source                     = "./modules/ecs/fargate"
  vpc_id                     = data.aws_vpc.default_vpc.id
  ecs_cluster_name           = "waycab-ecs-cluster"
  task_definition_family     = "waycab-fargate-tdf"
  container_name             = "hellopy-container"
  container_image            = "303981612052.dkr.ecr.eu-west-1.amazonaws.com/waycab/hellopy:latest"
  service_name               = "waycab-fargate-service"
  desired_count              = 2
  subnet_id                  = data.aws_subnet.private_subnet.id
  container_port             = 8080
  host_port                  = 8080
  cpu                        = 256
  memory                     = 512
  execution_role_arn         = data.aws_iam_role.task_ecs.arn
}

# Create a Load Balancer that routes to the application in the Private Subnet. Make sure to modify the Fargate SG to only receive requests directly from the Load Balancer
module "load_balancer"  {
  source = "./modules/load-balancer"
  vpc_id                     = data.aws_vpc.default_vpc.id
  alb_name                   = "waycab-alb"
  alb_sg_name                = "waycab-alb-sg"
  alb_tg_name                = "waycab-tg"
  app_port                   = 8080
  public_subnets             = ["subnet-0776e43e052640034", "subnet-825207e4"]
  task_ips                   = ["172.31.64.160", "172.31.64.161"]
}