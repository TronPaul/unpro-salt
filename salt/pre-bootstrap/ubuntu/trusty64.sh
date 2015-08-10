#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq

# salt deps
apt-get install -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" python-pip python-dev
pip -q install -U 'tornado >= 4.0'

# salt folders not created by bootstrap
mkdir /var/log/salt
mkdir /var/cache/salt
mkdir /var/run/salt
