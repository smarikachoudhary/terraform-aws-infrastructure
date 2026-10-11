provider "aws" {
region = "ap-south-1"
}

resource "aws_vpc" "main" {
cidr_block           = "10.0.0.0/16"
enable_dns_support   = true
enable_dns_hostnames = true

tags = {
Name = "Terraform-Project-VPC"
}
}

resource "aws_subnet" "public" {
vpc_id                  = aws_vpc.main.id
cidr_block              = "10.0.1.0/24"
availability_zone       = "ap-south-1a"
map_public_ip_on_launch = true

tags = {
Name = "Terraform-Project-Subnet"
}
}

resource "aws_internet_gateway" "main" {
vpc_id = aws_vpc.main.id

tags = {
Name = "Terraform-Project-IGW"
}
}

resource "aws_route_table" "public" {
vpc_id = aws_vpc.main.id

route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.main.id
}

tags = {
Name = "Terraform-Project-Route-Table"
}
}

resource "aws_route_table_association" "public" {
subnet_id      = aws_subnet.public.id
route_table_id = aws_route_table.public.id
}
resource "aws_security_group" "ssh" {
  name   = "terraform-ssh-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "Terraform-Project-SG"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = file("terraform-key.pub")
}

data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "web" {
  ami                         = data.aws_ssm_parameter.al2023.value
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ssh.id]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Terraform-EC2"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
