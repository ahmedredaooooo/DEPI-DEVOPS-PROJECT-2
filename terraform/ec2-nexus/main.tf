provider "aws" {
  region = var.region
}

# Import network outputs
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "dev-ops-terraform-state"
    key    = "global/terraform.tfstate"
    region = var.region
  }
}

# Security Group for Nexus
resource "aws_security_group" "nexus_sg" {
  name        = "nexus-sg"
  description = "Allow SSH, HTTP, Docker ports"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nexus-sg"
  }
}

# EC2 Instance for Nexus
resource "aws_instance" "nexus" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              =  data.terraform_remote_state.network.outputs.public_subnets[0]
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.nexus_sg.id]

  tags = {
    Name = "nexus-server"
  }

  associate_public_ip_address = true
}
