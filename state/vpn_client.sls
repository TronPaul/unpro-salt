include:
  - libreswan.common
  - xl2tpd

connect_ipsec:
  cmd.run:
    - name: ipsec auto --up {{ name }}
    - require:
      - service: ipsec
