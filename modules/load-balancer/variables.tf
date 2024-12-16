variable "vpc_id" {
    description = "The VPC id."
    type = string
}

variable "alb_name" {
    description = "Application load balancer name."
    type = string
}

variable "alb_sg_name" {
    description = "Application load balancer security group name."
    type = string
}

variable "alb_tg_name" {
    description = "Application load balancer target group name."
    type = string
}

variable "app_port" {
    description = "Application port of the ECS tasks."
    type = string
}

variable "public_subnets" {
    description = "Public subnets to deploy ALB."
    type = list(string)
}


variable "task_ips" {
    description = "Task IP Addresses."
    type = list(string)
}