 Prerequisites:

 1. AWS Account (Free Tier)

 2. AWS CLI configured (aws configure)

 3. Terraform installed

 4. Spring Boot .jar built (mvn clean package)

 5. Git & SSH key pair ready
 //aws ec2 create-key-pair --key-name my-key --query 'KeyMaterial' --output text > my-key.pem
chmod 400 my-key.pem