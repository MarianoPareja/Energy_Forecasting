provider "aws" {
  region = "sa-east-1"
}

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

resource "aws_security_group" "website-security-group" {
  name        = "EnergyForecasting_SecurityGroup"
  description = "Allow Frontend/Airflow UI traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  tags = {
    Name = "EnergyForecasting_SecurityGroup"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_sg" {
  security_group_id = aws_security_group.website-security-group.id

  ip_protocol = -1
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "web_traffic_sg" {
  security_group_id = aws_security_group.website-security-group.id

  from_port   = 80 # HTTP Communication
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ssh_sg" {
  security_group_id = aws_security_group.website-security-group.id

  from_port   = 22 # SSH Communication
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}


resource "aws_vpc_security_group_ingress_rule" "web_server_sg" {
  security_group_id = aws_security_group.website-security-group.id

  from_port   = 8501 # App web server
  to_port     = 8502 # Monitoring web server
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "airflow_sg" {
  security_group_id = aws_security_group.website-security-group.id

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


# Create EC2 instances

resource "aws_instance" "web_server_instance" {
  ami                         = "ami-08af887b5731562d3"
  associate_public_ip_address = "true"
  instance_type               = "t2.micro"
  availability_zone           = "sa-east-1a"
  key_name                    = "TF_EnergyConsumption"
  subnet_id                   = aws_subnet.subnet-1.id

  vpc_security_group_ids = [aws_security_group.website-security-group.id]


  tags = {
    Name = "EnergyForecasting_MLPipeline_EC2"
  }
}


# resource "aws_instance" "ml_server" {
#   ami               = "ami-08af887b5731562d3"
#   instance_type     = "t2.micro"
#   key_name          = "TF_EnergyConsumption"
#   availability_zone = "sa-east-1a"

#   subnet_id = aws_subnet.subnet-1.id

#   tags = {
#     Name = "EnergyForecasting_Frontend_EC2"
#   }
# }


