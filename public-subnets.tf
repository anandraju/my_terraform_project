#Local variables
locals {
  az_names       = data.aws_availability_zones.azs.names
  public_sub_ids = aws_subnet.public.*.id
}


#Subnets: Public
resource "aws_subnet" "public" {
  count                   = length(local.az_names)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}


#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mainIgw"
  }
}

resource "aws_route_table" "prt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "mainPRT"
  }
}

resource "aws_route_table_association" "pub_subnet_association" {
  count          = length(local.az_names)
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.prt.id
}
