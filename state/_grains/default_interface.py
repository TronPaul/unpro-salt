#!/usr/bin/env python
import subprocess
import re

DEFAULT_IFACE_LINE_PATTERN = re.compile('^0.0.0.0.*$', re.MULTILINE)

def default_interface():
    netstat = subprocess.check_output(['/bin/netstat','-nr'])
    def_iface_line = DEFAULT_IFACE_LINE_PATTERN.search(netstat)
    if def_iface_line:
        def_iface = def_iface_line.group().split()[-1]
    else:
        def_iface = None
    return {'default_interface': def_iface}
