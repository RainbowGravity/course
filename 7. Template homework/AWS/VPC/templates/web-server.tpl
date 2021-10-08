#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo aws s3 cp s3://${bucket}/index.html /usr/share/nginx/html/index.html --endpoint-url https://s3.${region}.amazonaws.com
sudo systemctl start nginx
sudo systemctl enable nginx