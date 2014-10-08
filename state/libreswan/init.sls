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

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
    - require_in:
      - service: ipsec

net.ipv4.conf.default.rp_filter:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.all.rp_filter:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.default.accept_source_route:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv6.conf.default.accept_source_route:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.all.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv6.conf.all.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.default.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv6.conf.default.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

ipsec:
  service.running:
    - enable: True
    - require:
      - file: ipsec.secrets_permissions
      - file: ipsec.secrets_exists
      - file: /etc/ipsec.conf
      - cmd: init_cert
