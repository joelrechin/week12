resource "aws_vpc" "week12-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "week12-vpc"
  }
}

resource "aws_subnet" "week12-sub-a" {
  vpc_id                  = aws_vpc.week12-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "week12-sub-a"
  }
}

resource "aws_subnet" "week12-sub-b" {
  vpc_id                  = aws_vpc.week12-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "week12-sub-b"
  }
}

resource "aws_subnet" "week12-pri-a" {
  vpc_id                  = aws_vpc.week12-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "week12-pri-a"
  }
}

resource "aws_subnet" "week12-pri-b" {
  vpc_id                  = aws_vpc.week12-vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "week12-pri-b"
  }
}

resource "aws_internet_gateway" "week12-igw" {
  vpc_id = aws_vpc.week12-vpc.id

  tags = {
    Name = "week12-igw"
  }
}

resource "aws_default_route_table" "week12-rt" {
  default_route_table_id = aws_vpc.week12-vpc.default_route_table_id

  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.week12-igw.id

      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    }
  ]

  tags = {
    Name = "week12-rt"
  }
}

resource "aws_route_table" "week12-pri-rt" {
  vpc_id = aws_vpc.week12-vpc.id

  route = []

  tags = {
    Name = "week12-pri-rt"
  }
}


resource "aws_route_table_association" "week12-pri-a-rta" {
  subnet_id      = aws_subnet.week12-pri-a.id
  route_table_id = aws_route_table.week12-pri-rt.id
}

resource "aws_route_table_association" "week12-pri-b-rta" {
  subnet_id      = aws_subnet.week12-pri-b.id
  route_table_id = aws_route_table.week12-pri-rt.id
}
