resource "aws_security_group" "spring_sg" {
  name        = "spring_sg"
  description = "Allow SSH and HTTP"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "springboot_app" {
  ami                    = "ami-0c7217cdde317cfec" # Amazon Linux 2 (Free Tier)
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.spring_sg.id]
  user_data              = file("${path.module}/user-data.sh")

  tags = {
    Name = "SpringBootApp"
  }
}