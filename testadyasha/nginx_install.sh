#!/bin/bash
export http_proxy=http://proxy.tcs.com:8080/
export https_proxy=https://proxy.tcs.com:8080/
sudo cp resolv.conf /etc/.
mkdir testdir
#sudo apt-get install git -y
apt-get install -y nginx
#ufw allow 'Nginx HTTP'
