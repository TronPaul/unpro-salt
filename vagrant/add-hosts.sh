#!/bin/sh

if ! grep -q '^192.168.51.2 vpn.teamunpro.com' /etc/hosts; then
    sed -i '/127.0.0.1\(\s\+\w\+\)\+/a 192.168.51.2 vpn.teamunpro.com' /etc/hosts
fi
