resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidr_block
  availability_zone       = var.public_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_name
    Type = "Public"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_cidr_block
  availability_zone       = var.private_availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = var.private_subnet_name
    Type = "Private"
  }
}

# Public Internet Gateway for the public subnet. NOTE: IGW already exists
# resource "aws_internet_gateway" "internet_gateway" {
#   vpc_id = var.vpc_id

#   tags = {
#     Name = var.igw_name
#   }
# }

# Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  depends_on = [var.internet_gateway_id]
}

# Create a NAT Gateway in the public subnet. Necessary for Private subnet instances' internet connection.
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = var.nat_gw_name
  }
}

# Route Table for the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.public_route_table_name
  }
}

# Default route to the Internet Gateway for the public subnet
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

# Associate the public route table with the public subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Route Table for the private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.private_route_table_name
  }
}

# Default route for the private subnet to go through the NAT Gateway
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Associate the private route table with the private subnet
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

