#!/bin/bash

RADXA_USER_HOME=/home/radxa

# make radxa directory
if [ ! -d $RADXA_USER_HOME/scripts ];then
    mkdir $RADXA_USER_HOME/scripts
fi

if [ ! -d $RADXA_USER_HOME/Videos ];then
    mkdir $RADXA_USER_HOME/Videos
fi


sudo chmod +x $RADXA_USER_HOME/scripts/resizefs.sh
sudo chmod +x $RADXA_USER_HOME/scripts/stream.sh
sudo chmod +x $RADXA_USER_HOME/scripts/wifi-connect.sh

## Install Nginx server for Video sharing
sudo apt install nginx-light
sudo chmod o+x /home /home/radxa /home/radxa/Videos
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.old
sudo nano /etc/nginx/sites-available/default

## Install webng
cp /etc/systemd/system/openipc.service

sudo apt-get install dkms
# For 8812au:
git clone -b v5.2.20 https://github.com/svpcom/rtl8812au.git
cd rtl8812au/
# For 8812eu:
git clone -b v5.15.0.1 https://github.com/svpcom/rtl8812eu.git
cd rtl8812eu/
# For both:
sudo ./dkms-install.sh

echo "Installing wfb-ng"
git clone -b stable https://github.com/svpcom/wfb-ng.git
cd wfb-ng
sudo ./scripts/install_gs.sh wlan0


sudo systemctl daemon-reload
sudo systemctl enable wifibroadcast@gs
sudo systemctl start wifibroadcast@gs
