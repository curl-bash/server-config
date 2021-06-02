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

# install github cli
curl spellcaster.sh/gh | bash

# create user
useradd -p $(openssl passwd -1 raspberry) -m $name
mkdir /home/$name/.ssh
cp /home/pi/.ssh/authorized_keys /home/$name/.ssh/
chown $name:$name /home/$name/.ssh/authorized_keys
usermod -aG sudo $name

# generate ssh key
ssh-keygen -t ed25519 -q -C "$name@curlbash.tech" -f "/home/$name/.ssh/id_rsa" -N ""

echo "configuring nginx..."
cp nginx_configs/curlbash /etc/nginx/sites-enabled/curlbash
systemctl restart nginx


