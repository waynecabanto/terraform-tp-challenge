# outputs.tf

output "public_subnet_id" {
  description = "The ID of the public subnet."
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet."
  value       = aws_subnet.private_subnet.id
}

# output "internet_gateway_id" {
#   description = "The ID of the Internet Gateway."
#   value       = aws_internet_gateway.internet_gateway.id
# }

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = aws_nat_gateway.nat_gateway.id
}
