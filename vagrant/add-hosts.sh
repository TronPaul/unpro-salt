#!/bin/sh

if ! grep -q '^192.168.50.4 nasus' /etc/hosts; then
    sed -i '/127.0.0.1\(\s\+\w\+\)\+/a 192.168.50.4 nasus' /etc/hosts
fi
