include:
  - openvpn

/etc/openvpn/secret:
  file.managed:
    - owner: root
    - group: root
    - mode: 600
    - source: salt://openvpn/secret
    - require_in:
      - service: openvpn
