{%- set ipsec_name = salt['pillar.get']('libreswan:name') -%}
{%- set ipsec_left = salt['pillar.get']('libreswan:left') -%}
{%- set ipsec_right = salt['pillar.get']('libreswan:right') -%}

include:
  - libreswan.common
  - xl2tpd.client

connect_ipsec:
  cmd.run:
    - name: ipsec auto --up {{ ipsec_name }}
    - unless: ip xfrm state | grep -q '^src {{ ipsec_left }} dst {{ ipsec_right }}$' && ip xfrm state | grep -q '^src {{ ipsec_right }} dst {{ ipsec_left }}'
    - require:
      - service: ipsec

connect_l2tp:
  cmd.run:
    - name: xl2tpd-control connect teamunpro
    - require:
      - cmd: connect_ipsec
