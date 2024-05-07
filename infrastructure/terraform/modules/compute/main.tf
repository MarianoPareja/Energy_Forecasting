# Create EC2 instances

resource "aws_instance" "web_server_instance" {
  ami                         = "ami-08af887b5731562d3"
  associate_public_ip_address = "true"
  instance_type               = "t2.micro"
  availability_zone           = "sa-east-1a"
  key_name                    = "TF_EnergyConsumption"
  subnet_id                   = var.subnet_id

  vpc_security_group_ids = [var.website_sg_id]

  root_block_device {
    volume_size           = "20"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "EnergyForecasting_Webserver"
  }
}


resource "aws_instance" "ml_server" {
  ami                         = "ami-08af887b5731562d3"
  associate_public_ip_address = "true"
  instance_type               = "t2.micro"
  key_name                    = "TF_EnergyConsumption"
  availability_zone           = "sa-east-1a"
  subnet_id                   = var.subnet_id

  vpc_security_group_ids = [var.mlserver_sg_id]

  root_block_device {
    volume_size           = "10"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "EnergyForecasting_MLServer"
  }
}
