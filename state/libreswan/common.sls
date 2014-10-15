include:
  - .build

/etc/ipsec.conf:
  file.managed:
    - source: salt://libreswan/ipsec.conf.jinja
    - user: root
    - group: root
    - template: jinja

/etc/ipsec.secrets:
  file.managed:
    - name: /etc/ipsec.secrets
    - source: salt://libreswan/ipsec.secrets.jinja
    - template: jinja
    - replace: False
    - user: root
    - group: root
    - mode: 0600

/etc/init/ipsec.conf:
  file.managed:
    - source: salt://libreswan/ipsec.init.conf
    - user: root
    - group: root
    - mode: 755

/etc/default/ipsec:
  file.managed:
    - source: salt://libreswan/ipsec
    - replace: False
    - user: root
    - group: root
    - mode: 644

ipsec:
  service.running:
    - enable: True
    - require:
      - file: /etc/ipsec.secrets
      - file: /etc/init/ipsec.conf
      - file: /etc/default/ipsec
      - file: /etc/ipsec.conf
      - cmd: init_cert
    - watch:
      - file: /etc/ipsec.conf
