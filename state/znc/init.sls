znc:
  pkg:
    - installed
  user.present:
    - system: True
    - home: /var/lib/znc
    - shell: /usr/sbin/nologin
    - gid_from_name: True
