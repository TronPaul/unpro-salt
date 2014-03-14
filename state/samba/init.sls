samba:
  package:
    - installed
  service:
    - running
    - watch:
      - file: /etc/samba/smb.conf

/etc/samba/smb.conf:
  file.managed:
    - source: salt://samba/smb.conf
