{%- if salt['grains.get']('virtual') == 'VirtualBox' and salt['grains.get']('ip_interfaces:eth1') -%}
{%- set left_id = salt['grains.get']('ip_interfaces:eth1')[0] -%}
{%- else -%}
{%- set left_id = salt['grains.get']('external_ip') -%}
{%- endif -%}

libreswan:
  version: '3.10'
  hash: 29342ba5c92e0be22d5803092dd67e6d50965b3e
  name: teamunpro
  left_id: {{ salt['grains.get']('ip_interfaces:eth1') }}
  right_subnet_within: 0.0.0.0/0
