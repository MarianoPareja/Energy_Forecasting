provider "aws" {
    region = "sa-east-1"
}

# Create VPC

resource "aws_vpc" "prod-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "production"
    }
}

# Create Intenet Gateway

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.prod-vpc.id
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
    Name = "Prod"
  }
}

# Create security groups

resource "aws_security_group" "website-security-group" {
    name = "allow website trafic"
    description = "allow website traffic"
    vpc_id = aws_vpc.prod-vpc.id

    ingress {
        from_port = 8501
        to_port = 8502
        protocol = "tcp"
    }
    ingress {
        from_port = 8001
        to_port = 8001
        protocol = "tcp"
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
    }
    egress {
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
    }
}

# Create Subnet

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "prod-subnet"
  }
}

# Create EC2 instances

resource "aws_instance" "web_server_instance" {
    ami = "ami-08af887b5731562d3"
    instance_type = "t2.micro"
    availability_zone = "sa-east-1a"
    # key_name = "main-key"

    subnet_id = aws_subnet.subnet-1.id
}


resource "aws_instance" "ml_server" {
    ami = "ami-08af887b5731562d3"
    instance_type = "t2.micro"
    availability_zone = "sa-east-1a"
    # key_name = "main-key"

    subnet_id = aws_subnet.subnet-1.id
}

# # Attach Elastic IP to webserver

# resource "aws_eip" "one" {
#     domain = "vpc"

#     instance = aws_instance.web_server_instance.id
#     associate_with_private_ip = "10.0.1.10"

# }