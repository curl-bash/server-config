# server configuration for raspberry pi

#!/bin/bash

name=$1
site=$2

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
apt install git nginx openjdk-11-jdk-headless screen

# install minecraft server
# download minecraft server if not already downloaded
if [[ -e server.jar ]]
  then echo "server.jar exists!"
  else curl https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar -o server.jar
fi
echo "eula=true" > eula.txt

screen -dm java -Xmx1024M -Xms1024M -jar server.jar nogui 

# deploy website
curl -L  https://github.com/$site/archive/refs/heads/main.zip -o site.zip 
unzip -o -j site.zip -d curlbash 
cp -r curlbash /var/www/

