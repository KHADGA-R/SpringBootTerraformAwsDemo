output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.springboot_app.public_ip
}
