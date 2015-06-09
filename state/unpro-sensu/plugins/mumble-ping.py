#!/usr/bin/env python
# -*- coding: utf-8
# Based on pcgod's mumble-ping script found at http://0xy.org/mumble-ping.py.

from struct import *
import socket, sys, time, datetime, argparse


def ping_mumble(host, port):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.settimeout(1)

    buf = pack(">iQ", 0, datetime.datetime.now().microsecond)
    s.sendto(buf, (host, port))

    try:
        data, addr = s.recvfrom(1024)
    except socket.timeout:
        return None
    return data

def decode_ping(data):
    r = unpack(">bbbbQiii", data)

    # r[0,1,2,3] = version
    # r[4] = ts
    # r[5] = users
    # r[6] = max users
    # r[7] = bandwidth
    version = r[1:4]

    ping = (datetime.datetime.now().microsecond - r[4]) / 1000.0
    if ping < 0: ping = ping + 1000
    return {"version": version,
            "users": r[5],
            "max_users": r[6],
            "bandwidth": r[7]/1000,
            "ping": ping}


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--host', default='localhost')
    parser.add_argument('-p', '--port', type=int, default=64738)
    parser.add_argument('-w', '--warn-over', type=int, default=50)
    parser.add_argument('-c', '--critical-over', type=int, default=100)
    args = parser.parse_args()
    d = ping_mumble(args.host, args.port)
    if d:
        ping = decode_ping(d)['ping']
    else:
        ping = None
    
    if not ping:
        print 'CRITICAL: No connection'
        sys.exit(2)
    elif ping > args.critical_over:
        print 'CRITICAL: Ping {} is over {}'.format(ping, args.critical_over)
        sys.exit(2)
    elif ping > args.warn_over:
        print 'WARN: Ping {} is over {}'.format(ping, args.warn_over)
        sys.exit(1)
    else:
        print 'OK'
        sys.exit(0)
