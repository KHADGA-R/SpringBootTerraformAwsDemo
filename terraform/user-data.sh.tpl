#!/bin/bash
yum update -y
amazon-linux-extras enable corretto17
yum install -y java-17-amazon-corretto
aws s3 cp s3://${s3_bucket}/${jar_key} /home/ec2-user/demo.jar
cd /home/ec2-user
nohup java -jar demo.jar > output.log 2>&1 &
