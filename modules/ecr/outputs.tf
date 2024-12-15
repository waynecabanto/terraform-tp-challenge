output "repository_url" {
  description = "The URL of the created ECR repository."
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "The ARN of the created ECR repository."
  value       = aws_ecr_repository.this.arn
}