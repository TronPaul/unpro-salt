pillar_roots:
  base:
    - /srv/pillar

base:
  '*':
    - users
  'roles:vpn_client':
    - match: grain
    - openvpn_client
  'teamunpro.com*':
    - mumble-servers
    - openssh
  'nasus':
    - nasus_samba
    - nasus_nfs
  'fednet':
    - fednet_nfs_client
