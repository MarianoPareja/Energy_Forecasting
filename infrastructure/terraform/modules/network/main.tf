# Create VPC

resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "EnergyForecasting_VPC"
  }
}

# Create Intenet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    Name = "EnergyForecasting_IGW"
  }
}

# Create custom route table 

resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "EnergyForecasting_RouteTable"
  }
}

# Create security groups

resource "aws_security_group" "website_security_group" {
  name        = "Website security group"
  description = "Allow Frontend/ UI traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  tags = {
    Name = "EnergyForecasting_SecurityGroup"
  }
}


resource "aws_vpc_security_group_egress_rule" "webserver_sg_1" {
  security_group_id = aws_security_group.website_security_group.id

  ip_protocol = -1
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "webserver_sg_2" {
  security_group_id = aws_security_group.website_security_group.id

  from_port   = 80 # HTTP Communication
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "webserver_sg_3" {
  security_group_id = aws_security_group.website_security_group.id

  from_port   = 22 # SSH Communication
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}


resource "aws_vpc_security_group_ingress_rule" "webserver_sg_4" {
  security_group_id = aws_security_group.website_security_group.id

  from_port   = 8501 # App web server
  to_port     = 8502 # Monitoring web server
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_security_group" "mlserver_security_group" {
  name        = "ML server security group"
  description = "Allow Aiflow UI traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  tags = {
    Name = "EnergyForecasting_SecurityGroup"
  }
}

resource "aws_vpc_security_group_egress_rule" "mlserver_sg_1" {
  security_group_id = aws_security_group.mlserver_security_group.id

  ip_protocol = -1
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "mlserver_sg_2" {
  security_group_id = aws_security_group.mlserver_security_group.id

  from_port   = 80 # HTTP Communication
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "mlserver_sg_3" {
  security_group_id = aws_security_group.mlserver_security_group.id

  from_port   = 22 # SSH Communication
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "mlserver_sg_4" {
  security_group_id = aws_security_group.mlserver_security_group.id

  from_port   = 8080 # Airflow web server
  to_port     = 8080
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}



# Create Subnet

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "EnergyForecasting_Subnet"
  }
}

# Subnet Association

resource "aws_route_table_association" "ami-1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-route-table.id
}


## OUTPUT VALUES 
output "subnet_id" {
  value = aws_subnet.subnet-1.id
}

output "website_sg_id" {
  value = aws_security_group.website_security_group.id
}

output "mlserver_sg_id" {
  value = aws_security_group.mlserver_security_group.id
}
