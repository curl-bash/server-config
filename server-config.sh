#!/bin/bash -e

# server configuration for raspberry pi

name=$1
echo "Running configuration..."

echo "Adding user $name"
useradd -p $(openssl passwd -1 rasp) -G sudo -m $name 
mkdir /home/$name/.ssh
cp /home/pi/.ssh/authorized_keys /home/$name/.ssh/
chown -R $name:$name /home/$name/.ssh

# update system
apt update
apt upgrade -y

# install packages
apt install git nginx openjdk-11-jdk-headless screen

# setup 'minecraft' user to run the Minecraft server
mcuser="minecraft"
echo "Adding $mcuser user"
# does mcuser need to login?
useradd -p $(openssl passwd -1 rasp) -G sudo -m $mcuser 
mkdir -p /home/$mcuser

# change to mcuser dir after saving current dir
CWD=$(pwd)
cd /home/$mcuser

# download minecraft server if not already downloaded
[[ ! -e server.jar ]] \
  && curl https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar -o server.jar
echo "eula=true" > eula.txt

# make sure mcuser owns their files
chown -R $mcuser:$mcuser /home/$mcuser

sudo -u $mcuser java -Xmx1024M -Xms1024M -jar server.jar nogui 

cd $CWD
