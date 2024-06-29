#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>This is my virtual server</h1>" | tee /usr/share/nginx/html/index.html 