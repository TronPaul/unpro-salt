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
    - nasus_libreswan
    - nasus_xl2tpd
  'fednet':
    - fednet_nfs_client
  'vpn':
    - vpn_libreswan
    - vpn_xl2tpd
