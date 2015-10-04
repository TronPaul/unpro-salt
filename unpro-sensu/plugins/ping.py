#!/usr/bin/env python
import argparse
import sys
import platform
import subprocess

def ping(host, count, timeout, interval):
    sys_name = platform.system()
    ping_cmd = ['ping']
    if sys_name == 'Linux':
        ping_cmd.extend(['-q', '-c', str(count), '-W', str(timeout), host, '-i', str(interval)])
    else:
        raise NotImplementedError(sys_name)
    ping = subprocess.Popen(ping_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = ping.communicate()
    if ping.returncode == 0:
        return count
    elif ping.returncode == 2:
        return 0
    else:
        return 0

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--host', default='localhost')
    parser.add_argument('-T', '--timeout', default=5)
    parser.add_argument('-i', '--interval', default=1)
    parser.add_argument('-c', '--count', default=1)
    parser.add_argument('-w', '--warn-under', type=int, default=.9)
    parser.add_argument('-C', '--critical-under', type=int, default=.8)
    args = parser.parse_args()
    res = ping(args.host, args.count, args.timeout, args.interval) / args.count
    
    if not res:
        print 'CRITICAL: No connection'
        sys.exit(2)
    elif res < args.critical_under:
        print 'CRITICAL: Ping success {} is under {}'.format(res, args.critical_under)
        sys.exit(2)
    elif res < args.warn_under:
        print 'WARN: Ping success {} is under {}'.format(res, args.warn_under)
        sys.exit(1)
    else:
        print 'OK'
        sys.exit(0)

