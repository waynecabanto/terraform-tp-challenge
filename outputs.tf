output "ecr_repo_url" {
  value = module.ecr_repository.repository_url
}

output "ecr_repo_arn" {
  value = module.ecr_repository.repository_arn
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "private_subnet_id" {
  value = module.network.private_subnet_id
}

output "nat_gateway_id" {
  value = module.network.nat_gateway_id
}