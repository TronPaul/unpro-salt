{% set openvpn_servers = salt['pillar.get']('openvpn::servers', []) %}

include:
  - .common

{% for server in openvpn_servers %}
/etc/openvpn/{{server}}.conf:
  file.managed:
    - source: salt://openvpn/client.conf.jinja
    - template: jinja
    - context:
      server: {{server}}
    - require:
      - pkg: openvpn
    - watch_in:
      - service: openvpn
