#create vpc
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags       = {
     Name = "two-tier-app" }

}

#public subnet 1
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public_subnet_1"
  }

}

# Public Subnet 2
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.myvpc.id 
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_2"
  }

}

#private subnet 1
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_subnet_1"
  }

}

#private subnet 2
resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private_subnet_2"
  }
}

#create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "vpc-igw"
  }

}

#public route table
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

#assitiate public route table with public subnet 1
resource "aws_route_table_association" "rt-aassoctiation" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route-table.id

}

#assitiate public route table with public subnet 2
resource "aws_route_table_association" "rt-assitiate2" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.route-table.id
  
}

