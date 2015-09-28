include:
  - openvpn

/etc/openvpn/secret:
  file.managed:
    - owner: root
    - group: root
    - mode: 600
    - source: salt://unpro-openvpn/secret
    - require_in:
      - service: openvpn
