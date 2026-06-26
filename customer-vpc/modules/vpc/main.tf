resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags, { Name = "${var.environment_name}-vpc" })

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { Name = "${var.environment_name}-igw" })
}


resource "aws_subnet" "public" {
  for_each                = { for id, az in local.azs : az => local.public_subnet[id] }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(var.tags, { Name = "${var.environment_name}-public-${each.key}" })

}

resource "aws_subnet" "private" {
  for_each          = { for id, az in local.azs : az => local.private_subnet[id] }
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key


  tags = merge(var.tags, { Name = "${var.environment_name}-private-${each.key}" })

}

resource "aws_eip" "ngw_eip" {

  tags = merge(var.tags, { Name = "${var.environment_name}-eip" })
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_eip.id
  subnet_id     = values(aws_subnet.public)[0].id


  tags = merge(var.tags, { Name = "${var.environment_name}-ngw" })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, { Name = "${var.environment_name}-public-rt" })


}

resource "aws_route_table_association" "public-association" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = merge(var.tags, { Name = "${var.environment_name}-private-rt" })


}

resource "aws_route_table_association" "private-association" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-rt.id
}