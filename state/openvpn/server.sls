{% set fqdn = grains['fqdn'] %}

key-files:
  file.exists:
    - names:
      - /etc/openvpn/{{fqdn}}.key
      - /etc/openvpn/{{fqdn}}.crt
      - /etc/openvpn/ca.crt
      - /etc/openvpn/dh2048.pem

openvpn:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/openvpn/server.conf
    - require:
      - file: key-files

/etc/openvpn/server.conf:
  file.managed:
    - source: salt://openvpn/server.conf.jinja
    - template: jinja
    - require:
      - pkg: openvpn
