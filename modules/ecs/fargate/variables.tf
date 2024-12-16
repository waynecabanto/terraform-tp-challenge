variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The id of the vpc."
  type        = string
}

variable "subnet_id" {
  description = "The id of the subnet where to deploy fargate instances."
  type        = string
  
}

variable "task_definition_family" {
  description = "The family of the ECS task definition"
  type        = string
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "container_image" {
  description = "The image of the container"
  type        = string
}

variable "cpu" {
  description = "The number of CPU units for the task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "The amount of memory (in MiB) for the task"
  type        = string
  default     = "512"
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "The desired number of task instances"
  type        = number
  default     = 1
}

variable "container_port" {
  description = "The application's container port"
  type        = number
  default     = 80
}

variable "host_port" {
  description = "The application's host port."
  type        = number
  default     = 80
}

variable "execution_role_arn" {
  description = "The task execution role arn."
  type        = string
}