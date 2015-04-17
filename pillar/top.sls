pillar_roots:
  base:
    - /srv/pillar

base:
  '*':
    - users
  'roles:vpn_client':
    - match: grain
    - openvpn_client
  'roles:vpn_server':
    - match: grain
    - openvpn_server
  'roles:voice_server':
    - match: grain
    - mumble_servers
  'nasus':
    - nasus_samba
    - nasus_nfs
  'fednet':
    - fednet_nfs_client
  'ec2':
    - match: grain
