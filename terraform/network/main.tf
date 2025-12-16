provider "aws" {
  region = var.region
}

# ------------------------
# VPC
# ------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "dev-vpc"
  }
}

# ------------------------
# Internet Gateway
# ------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev-igw"
  }
}

data "aws_availability_zones" "available" {}

# ------------------------
# Public Subnets
# ------------------------
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "dev-public-subnet-${count.index + 1}"
"kubernetes.io/cluster/dev-eks" = "shared"
  "kubernetes.io/role/elb"        = "1"
  }
}

# ------------------------
# Private Subnets
# ------------------------
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone =  data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "dev-private-subnet-${count.index + 1}"
"kubernetes.io/cluster/dev-eks" = "shared"
  "kubernetes.io/role/internal-elb"        = "1"
  }
}

# ------------------------
# Public Route Table
# ------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  depends_on = [aws_nat_gateway.nat]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ------------------------
# NAT Gateway
# ------------------------
resource "aws_eip" "nat" {
  vpc = true 
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "dev-nat-gateway"
  }
}

# ------------------------
# Private Route Table
# ------------------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "dev-private-rt"
  }
}

resource "aws_route_table_association" "private_assoc" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
