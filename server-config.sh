# server configuration for raspberry pi

#!/bin/bash

name=$1
echo "Hello, $name"
echo "Running Configuration..."

apt update
apt upgrade -y
apt install openssh-server

echo "ip address of the server:"
ip --brief address show

whoami

adduser --disabled-password --gecos "" $name

cat /etc/passwd
apt install nginx
