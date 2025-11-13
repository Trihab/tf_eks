## ---------- VPC Public ----------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route table"
  }
}

resource "aws_subnet" "subnet_public_a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.2.1.0/24"

  tags = {
    Name = "Public Subnet A"
  }
}

resource "aws_route_table_association" "subnet_public_rta_a" {
  subnet_id      = aws_subnet.subnet_public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "subnet_public_b" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.2.2.0/24"

  tags = {
    Name = "Public Subnet B"
  }
}

resource "aws_route_table_association" "subnet_public_rta_b" {
  subnet_id      = aws_subnet.subnet_public_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "subnet_public_c" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.2.3.0/24"

  tags = {
    Name = "Public Subnet C"
  }
}

resource "aws_route_table_association" "subnet_public_rta_c" {
  subnet_id      = aws_subnet.subnet_public_c.id
  route_table_id = aws_route_table.public_rt.id
}