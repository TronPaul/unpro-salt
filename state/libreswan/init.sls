include:
  - .build

/etc/ipsec.conf:
  file.managed:
    - source: salt://libreswan/ipsec.conf.jinja
    - user: root
    - group: root
    - template: jinja

ipsec.secrets_permissions:
  file.managed:
    - name: /etc/ipsec.secrets
    - create: False
    - replace: False
    - user: root
    - group: root
    - mode: 0600

ipsec.secrets_exists:
  file.exists:
    - name: /etc/ipsec.secrets

ipsec:
  service.running:
    - enable: True
    - require:
      - file: ipsec.secrets_permissions
      - file: ipsec.secrets_exists
      - file: /etc/ipsec.conf
