#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -q
sudo apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" python-pip python-dev
sudo pip install -U 'tornado >= 4.0'
sudo mkdir /var/log/salt
