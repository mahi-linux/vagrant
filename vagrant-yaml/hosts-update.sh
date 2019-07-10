#!/bin/bash
# Delete very first file as Vagrant update the first line
if [ $(grep example /etc/hosts | wc -l) -gt 0 ] ; then
sudo sed -i '1d' /etc/hosts >/dev/null
fi

# update hosts manually
sudo echo -e "192.168.10.11   sal-saltp01.example.in  sal-saltp01 salt" >> etc/hosts
sudo echo -e "192.168.10.10   gitlab.example.in       gitlab" >> etc/hosts
sudo echo -e "192.168.10.12   sal-webp01.example.in   sal-webp01 >> /etc/hosts
sudo echo -e "192.168.10.13  sal-webp02example.in   sal-webp02 >> /etc/hosts
