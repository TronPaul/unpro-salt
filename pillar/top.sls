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
