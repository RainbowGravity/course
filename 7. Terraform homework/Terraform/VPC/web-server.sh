#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
echo "Hello World! Made by Rainbow Gravity" > /var/www/html/index.html 
sudo systemctl start nginx
