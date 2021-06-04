# server configuration for raspberry pi

#!/bin/bash

name=$1
echo "Hello, $name"
echo "Running Configuration..."

# update system
apt update
apt upgrade -y

# install packages 
apt install git nginx openjdk-11-jdk-headless

echo "ip address of the server:"
ip --brief address show

echo "adding user $name"
adduser --disabled-password --gecos "" $name

echo "configuring nginx..."
cp nginx_configs/curlbash /etc/nginx/sites-enabled/curlbash
systemctl restart nginx


