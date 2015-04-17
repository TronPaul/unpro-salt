file_roots:
  base:
    - /srv/salt

base:
  '* and not G@virtual:VirtualBox':
    - match: compound
    - unpro_salt
  'roles:vpn_server':
    - match: grain
    - openvpn.server
  'roles:aws_nat':
    - match: grain
    - aws.nat
  'roles:voice_server':
    - match: grain
    - mumble_servers
  'roles:pythondev':
    - match: grain
    - dev.python
  'roles:sshserver':
    - match: grain
    - openssh
    - openssh.config
  'roles:torrentserver':
    - match: grain
    - deluge.deluged
    - deluge.deluge-web
    - deluge.proxy
  'roles:nas':
    - match: grain
    - samba
    - nfs.server
  'roles:dev':
    - match: grain
    - dev.python
    - dev.java
    - git
  'roles:htpc':
    - match: grain
    - xbmc
    - pcsx2
    - desmume
    - dolphin
  'roles:nas_client':
    - match: grain
    - nfs.client
  'roles:vpn_client':
    - match: grain
    - openvpn.client
  'G@roles:dev and G@roles:gui':
    - match: compound
    - virtualbox
