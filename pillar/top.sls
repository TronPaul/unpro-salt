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
  'nasus':
    - nasus_samba
    - nasus_nfs
  'roles:voice_server':
    - match: grain
    - mumble_servers
  'fednet':
    - fednet_nfs_client
