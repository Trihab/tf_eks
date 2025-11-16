## ---------- VPC Private ----------

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.subnet_public_a.id

  tags = {
    Name = "NAT Gateway Private Subnets"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "eip_nat" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Private Route table"
  }
}

resource "aws_subnet" "subnet_private_a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.2.10.0/24"

  tags = {
    Name = "Private Subnet A"
    Class = "Private"
  }
}

resource "aws_route_table_association" "subnet_private_rta_a" {
  subnet_id      = aws_subnet.subnet_private_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_subnet" "subnet_private_b" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.2.20.0/24"

  tags = {
    Name = "Private Subnet B"
    Class = "Private"
  }
}

resource "aws_route_table_association" "subnet_private_rta_b" {
  subnet_id      = aws_subnet.subnet_private_b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_subnet" "subnet_private_c" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.2.30.0/24"

  tags = {
    Name = "Private Subnet C"
    Class = "Private"
  }
}

resource "aws_route_table_association" "subnet_private_rta_c" {
  subnet_id      = aws_subnet.subnet_private_c.id
  route_table_id = aws_route_table.private_rt.id
}