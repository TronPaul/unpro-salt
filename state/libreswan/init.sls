include:
  - .build

/etc/ipsec.conf:
  file.managed:
    - source: salt://libreswan/ipsec.conf.jinja
    - user: root
    - group: root
    - template: jinja

secrets_permissions:
  file.managed:
    - name: /etc/ipsec.secrets
    - create: False
    - replace: False
    - user: root
    - group: root
    - mode: 0600

secrets_exists:
  file.exists:
    - name: /etc/ipsec.secrets

ipsec:
  service.running:
    - enable: True
    - require:
      - file: secrets_permissions
      - file: /etc/ipsec.conf
