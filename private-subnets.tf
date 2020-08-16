#Subnets: Private
resource "aws_subnet" "private" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + length(local.az_names))
  availability_zone = local.az_names[count.index]

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}

resource "aws_instance" "nat" {
  ami                         = var.nat_amis[var.AWS_REGION]
  instance_type               = "t2.micro"
  subnet_id                   = local.public_sub_ids[0]
  source_dest_check           = "false"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.nat_sg.id]
  tags = {
    Name = "MainNat"
  }
}

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat.id
  }

  tags = {
    Name = "mainPrivateRT"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = length(local.az_names)
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.privatert.id
}

resource "aws_security_group" "nat_sg" {
  name        = "nat_sg"
  description = "Allow traffic for Pricate Subnets"
  vpc_id      = aws_vpc.main.id

  #Not required Inbound Traffic
  /*  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
*/
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nat_sg"
  }
}
