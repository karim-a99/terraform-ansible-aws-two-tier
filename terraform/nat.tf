# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  
  tags = {
    Name = "nat-eip"
  }
}

# nAT gateway in public subnet 1
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "nat-gateway"
  }
  depends_on = [aws_internet_gateway.igw]
}

#private route table
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.myvpc.id

    route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

    tags = {
    Name = "private-rt"
  }
}
  
# Associate Private Route Table with Private Subnet 1
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Associate Private Route Table with Private Subnet 2
resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private.id
}
