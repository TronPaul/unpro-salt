
{%- if salt['grains.get']('virtual') == 'VirtualBox' -%}
{%- set lns = '192.168.50.3' -%}
{%- else -%}
{%- set lns = '54.172.122.148' -%}
{%- endif -%}
xl2tpd:
  lac:
    teamunpro:
      lns: {{ lns }}
      username: nasus
