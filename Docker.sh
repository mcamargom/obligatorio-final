#!/bin/bash
sudo su <<HERE
yum -y update
yum -y install git
amazon-linux-extras install -y docker
service docker start
git clone https://github.com/mcamargom/simple-ecomme /home/ec2-user/Docker/simple-ecomme
echo -e "FROM php:5.6-apache \nCOPY ./simple-ecomme /var/www/html \nRUN service apache2 start \nEXPOSE 80" > /home/ec2-user/Docker/Dockerfile
docker build /home/ec2-user/Docker -t ecommerce:v1
docker run -d -p 80:80 ecommerce:v1
HERE
