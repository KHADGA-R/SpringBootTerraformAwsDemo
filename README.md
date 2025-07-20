🚀 Spring Boot App Deployment on AWS EC2 using Terraform
This project automates the deployment of a Spring Boot application on an AWS EC2 instance using Terraform, S3, and user-data for boot-time provisioning.

Project Structure:
.
├── main.tf                # Infrastructure resources (EC2, SG, IAM, etc.)
├── variables.tf           # Input variables
├── terraform.tfvars       # Actual values for variables
├── user-data.sh.tpl       # EC2 startup script to install Java and run the JAR
├── outputs.tf             # Optional: Outputs like public IP
└── README.md              # You are here

Prerequisites:
AWS account and credentials configured (aws configure)

An existing EC2 key pair (or create one and store .pem)

JAR file built and uploaded to an S3 bucket (public or with IAM access)

Terraform installed (>= 1.0)

Setup Instructions:
1. Clone the repository
git clone https://github.com/your-username/terraform-springboot-deploy.git
cd terraform-springboot-deploy

2. Upload JAR to S3 :
Upload your Spring Boot JAR file to your S3 bucket:
aws s3 cp target/demo.jar s3://your-bucket-name/demo.jar

3. Fill in terraform.tfvars
Create a file called terraform.tfvars with your actual values:
new_key     = "your-ec2-key-name"
s3_bucket   = "your-bucket-name"
jar_key     = "demo.jar"
instance_type = "t2.micro"

4. Initialize Terraform
terraform init

5. Plan the deployment
terraform plan

6. Apply the infrastructure
terraform apply

Type yes to confirm.

7. Access your app
Once EC2 is provisioned and the app is started:

Visit http://<EC2_PUBLIC_IP>:8081/hello (or your app's path)

To get the public IP:

terraform output ec2_public_ip

🧹 Tear Down :
To destroy all created AWS resources:
terraform destroy


How It Works ?
A security group allows SSH (port 22) and app access (port 8081).

An IAM role grants EC2 read-only access to S3.

A user_data script:

Installs Java 17

Downloads the .jar from S3

Runs the app in the background


Example user-data.sh.tpl
#!/bin/bash
apt update -y
apt install -y openjdk-17-jdk awscli
aws s3 cp s3://${s3_bucket}/${jar_key} /home/ubuntu/demo.jar
chown ubuntu:ubuntu /home/ubuntu/demo.jar
sudo -u ubuntu nohup java -jar /home/ubuntu/demo.jar --server.port=8081 --server.address=0.0.0.0 > /home/ubuntu/output.log 2>&1 &


🧾 License
MIT © Khadga Parajuli