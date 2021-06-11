# server configuration for raspberry pi

#!/bin/bash

name=$1
echo "Running configuration..."

echo "Adding user $name"
useradd -p $(openssl passwd -1 raspberry) -G sudo -m $name 
mkdir /home/$name/.ssh
cp /home/pi/.ssh/authorized_keys /home/$name/.ssh/
chown -R $name:$name /home/$name/.ssh

# update system
apt update
apt upgrade -y

# install packages
apt install git nginx openjdk-11-jdk-headless

# echo "configuring nginx..."
# cp nginx_configs/curlbash /etc/nginx/sites-enabled/curlbash
# systemctl restart nginx
