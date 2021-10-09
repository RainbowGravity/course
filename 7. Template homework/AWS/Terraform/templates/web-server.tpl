#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo aws s3 cp s3://${bucket}/index.html /usr/share/nginx/html/index.html --endpoint-url https://s3.${region}.amazonaws.com
sudo sudo yum install -y https://s3.${region}.amazonaws.com/amazon-ssm-${region}/latest/linux_amd64/amazon-ssm-agent.rpm
sudo hostname -I >> /usr/share/nginx/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
