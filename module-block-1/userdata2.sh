#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>this is server-2 and server running with apache</h1>" | sudo tee /var/www/html/index.html
sudo systemctl restart apache2