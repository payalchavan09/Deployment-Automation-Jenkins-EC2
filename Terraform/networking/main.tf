# ---- networking/main.tf -----

data "aws_availability_zones" "available" {}

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "pc_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "pc_vpc-${random_integer.random.id}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "pc_public_subnet" {
  count                   = var.public_sn_count
  vpc_id                  = aws_vpc.pc_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "pc_public_ ${count.index + 1}"
  }
}

resource "aws_route_table_association" "pc_public_assoc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.pc_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.pc_public_rt.id
}
resource "aws_internet_gateway" "pc_internet_gateway" {
  vpc_id = aws_vpc.pc_vpc.id

  tags = {
    Name = "pc_igw"
  }
}

resource "aws_route_table" "pc_public_rt" {
  vpc_id = aws_vpc.pc_vpc.id
  tags = {
    Name = "pc_public"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.pc_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.pc_internet_gateway.id
  depends_on             = [aws_route_table.pc_public_rt]
}

resource "aws_security_group" "pc_sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.pc_vpc.id
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "pc_public_sg"
  }
}

