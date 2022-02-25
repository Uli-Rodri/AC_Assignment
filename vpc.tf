resource "aws_vpc" "uli_vpc" {
    cidr_block = "10.152.0.0/16"

    tags = {
        Name = "uli_vpc"
    }
}        

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.uli_vpc.id
  cidr_block        = "10.152.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"

  tags = {
      Name = "public_subnet"
    }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.uli_vpc.id
  cidr_block        = "10.152.10.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2a"

  tags = {
      Name = "private_subnet"
    }
}

resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.uli_vpc.id

    tags = {
        Name = "gateway"
    }
}

resource "aws_route_table" "public_table" {
    vpc_id = aws_vpc.uli_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
    }

}

resource "aws_route_table_association" "public_table" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_table.id
}

resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_nat_gateway" "nat_gw"{
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public_subnet.id
    depends_on = [aws_internet_gateway.gateway]
}

resource "aws_route_table" "private_table" {
    vpc_id = aws_vpc.uli_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw.id

    }
}

resource "aws_route_table_association" "private_table_association" {
    subnet_id       = aws_subnet.private_subnet.id
    route_table_id  = aws_route_table.private_table.id
}