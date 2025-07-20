

#!/bin/bash

apt update -y
apt install -y openjdk-17-jdk awscli

# Download JAR from S3 (note the space between source and destination)
aws s3 cp s3://terraform-test-bkt1/demo.jar /home/ubuntu/demo.jar

# Fix permissions so the 'ubuntu' user owns the file
chown ubuntu:ubuntu /home/ubuntu/demo.jar

# Run app as 'ubuntu' user
sudo -u ubuntu nohup java -jar /home/ubuntu/demo.jar --server.port=8081 --server.address=0.0.0.0 > /home/ubuntu/output.log 2>&1 &
