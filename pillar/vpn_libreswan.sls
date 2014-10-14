{%- if salt['grains.get']('virtual') == 'VirtualBox' and salt['grains.get']('ip_interfaces:eth1') -%}
{%- set left = salt['grains.get']('ip_interfaces:eth1')[0] -%}
{%- set interfaces = 'eth1' -%}
{%- else -%}
{%- set left_id = salt['grains.get']('external_ip') -%}
{%- endif -%}
libreswan:
  version: '3.10'
  hash: 29342ba5c92e0be22d5803092dd67e6d50965b3e
  {%- if interfaces is defined and interfaces %}
  interfaces: {{ interfaces }}
  {% endif %}
  name: teamunpro
  {%- if left %}
  left: {{ left }}
  {%- endif %}
  {%- if left_id is defined and left_id%}
  left_id: {{ left_id }}
  {%- endif %}
  right_subnet_within: 0.0.0.0/0
  secrets:
    - left: {{ left }}
