provider "aws" {
    region = "us-east-1"
}

# create vpc
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform_vpc"
  }
}

# create public subnet
resource "aws_subnet" "public_sub1" {
    map_public_ip_on_launch = true
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.myvpc.id

    tags = {
      Name = "public_subnet1"
    }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "igw1"
  }
}

# route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "route1"
  }
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# route table association
resource "aws_route_table_association" "assoc" {
  subnet_id = aws_subnet.public_sub1.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group
resource "aws_security_group" "web_sg" {
  name   = "web_sg"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
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
    Name = "web_security_group"
  }
}

# Key Pair
resource "aws_key_pair" "mykey" {
  key_name   = "terraform_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Ec2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 us-east-1
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.public_sub1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.mykey.key_name

  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx

cat <<EOT > /usr/share/nginx/html/index.html
${file("index.html")}
EOT

cat <<EOT > /usr/share/nginx/html/style.css
${file("style.css")}
EOT

EOF

  tags = {
    Name = "Terraform_Web_App"
  }
}

# Output
output "public_ip" {
  value = aws_instance.web_server.public_ip
}