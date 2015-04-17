znc:
  pkg:
    - installed
  user.present:
    - system: True
    - home: /var/lib/znc
    - shell: /usr/sbin/nologin
    - gid_from_name: True

znc-subdirs:
  file.directory:
    - names:
      - /var/lib/znc/configs
      - /var/lib/znc/modules
    - user: znc
    - group: znc
    - mode: 750
    - require:
      - user: znc

znc-configs:
  file.managed:
    - names:
      - /var/lib/znc/configs/znc.conf
    - user: znc
    - group: znc
    - mode: 640
    - require:
      - file: znc-subdirs

znc-pem:
  file.managed:
