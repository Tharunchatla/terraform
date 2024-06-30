#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo echo "<h1>This is my virtual server</h1>" | sudo tee /usr/share/nginx/html/index.html 
sudo systemctl restart nginx