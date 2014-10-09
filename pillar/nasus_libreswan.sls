{%- if salt['grains.get']('virtual') == 'VirtualBox' -%}
{%- set left = '192.168.50.4' -%}
{%- set right = '192.168.50.2' -%}
{%- else -%}
{%- set right = 'vpn.teamunpro.com' -%}
{%- set left = '192.168.1.10' -%}
{%- endif -%}

libreswan:
  name: teamunpro
  left: {{ left }}
  right: {{ right }}
  right_proto_port: 17/1701
  rekey: 'yes'
