variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the ECR repository."
  type        = map(string)
  default     = {}
}

variable "image_scanning" {
  description = "Enable image scanning on push."
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Can be MUTABLE or IMMUTABLE."
  type        = string
  default     = "MUTABLE"
}