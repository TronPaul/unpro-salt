pillar_roots:
  base:
    - /srv/pillar

base:
  '*':
    - users
  'teamunpro.com*':
    - mumble-servers
    - openssh
  'nasus':
    - nasus_samba
    - nasus_nfs
  'fednet':
    - fednet_nfs_client
  'vpn':
    - vpn_libreswan
