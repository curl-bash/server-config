# server configuration for raspberry pi

#!/bin/bash

name=$1
echo "Hello, $name"
echo "Running Configuration..."

# update system
apt update
apt upgrade -y

# install packages 
apt install -y nginx git

sudo useradd -p $(openssl passwd -1 raspberry) -m $name
sudo mkdir /home/$name/.ssh
sudo cp /home/pi/.ssh/authorized_keys /home/$name/.ssh/
sudo chown $name:$name /home/$name/.ssh/authorized_keys
usermod -aG sudo $name

echo "configuring nginx..."
cp nginx_configs/curlbash /etc/nginx/sites-enabled/curlbash
systemctl restart nginx


