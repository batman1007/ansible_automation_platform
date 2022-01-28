resource "aws_subnet" "private_subnet" {
  vpc_id            = data.aws_vpc.target_vpc.id
  cidr_block        = "172.31.50.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "AAP_Private"
  }
}

resource "aws_route_table" "private_routes" {
  vpc_id = data.aws_vpc.target_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "nat-09db2dd3417447d62"
  }

  tags = {
    Name = "AAPRoutes"
  }
}

resource "aws_route_table_association" "private_route" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_routes.id
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = data.aws_vpc.target_vpc.id
  cidr_block              = "172.31.51.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "AAP_Public_A"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = data.aws_vpc.target_vpc.id
  cidr_block              = "172.31.52.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "AAP_Public_B"
  }
}
