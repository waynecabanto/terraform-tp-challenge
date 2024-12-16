resource "aws_security_group" "ecs" {
  name        = "ecs_security_group"
  description = "Allow inbound traffic to ECS Fargate service"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.host_port
    to_port     = var.host_port
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_task_definition" "fargate_task" {
  family                   = var.task_definition_family
  execution_role_arn       = var.execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "fargate_service" {
  name            = var.service_name
  cluster         = var.ecs_cluster_name
  task_definition = aws_ecs_task_definition.fargate_task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [var.subnet_id]
    security_groups = [aws_security_group.ecs.id]
    assign_public_ip = false
  }
}
