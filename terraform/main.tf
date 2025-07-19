# Create a Security Group that allows SSH and HTTP (port 8080) access
resource "aws_security_group" "spring_sg" {
  name        = "spring_sg"
  description = "Allow SSH and HTTP for Spring Boot app"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH access
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # App access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM Role to allow EC2 to access AWS services (S3 in this case)
resource "aws_iam_role" "ec2_role" {
  name = "springboot-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach AmazonS3ReadOnlyAccess policy to the role
resource "aws_iam_policy_attachment" "s3_read_access" {
  name       = "s3-read-access"
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Create instance profile for EC2 to use the IAM role
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "springboot-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# Launch an EC2 instance with IAM profile and user-data to run the Spring Boot app
resource "aws_instance" "springboot_app" {
  ami                    = "ami-0c7217cdde317cfec"  # Amazon Linux 2 (Free Tier)
  instance_type          = var.instance_type        # From variables.tf
  key_name               = var.new-key             # Your EC2 key pair (e.g., "my-key")
  vpc_security_group_ids = [aws_security_group.spring_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  # Template file includes script to install Java and run the JAR from S3
  user_data = templatefile("${path.module}/user-data.sh.tpl", {
    s3_bucket = var.s3_bucket,
    jar_key   = var.jar_key
  })

  tags = {
    Name = "SpringBootApp"
  }
}
