variable "new_key" {
  description = "EC2 key pair name"
  default     = "new_key"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Free-tier EC2 instance type"
}

variable "s3_bucket" {
  default     = "terraform-test-bkt1"
  description = "S3 bucket where JAR is stored"
}

variable "jar_key" {
  default     = "demo.jar"
  description = "Key (path) of the JAR file in the S3 bucket"
}
