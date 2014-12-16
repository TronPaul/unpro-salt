{% set fqdn = grains['fqdn'] %}
{% set openvpn_servers = salt['pillar.get']('openvpn:servers', []) %}

include:
  - .common

key-files:
  file.exists:
    - names:
      - /etc/openvpn/{{ fqdn }}.crt
      - /etc/openvpn/{{ fqdn }}.key
      - /etc/openvpn/ca.crt

{% for server in openvpn_servers %}
/etc/openvpn/{{server}}.conf:
  file.managed:
    - source: salt://openvpn/client.conf.jinja
    - template: jinja
    - context:
      server: {{server}}
    - require:
      - pkg: openvpn
      - file: /etc/openvpn/update-resolv-conf.sh
    - watch_in:
      - service: openvpn
{% endfor %}

openresolv:
  pkg:
    - installed

/etc/openvpn/update-resolv-conf.sh:
  file.managed:
    - source: salt://openvpn/update-resolv-conf.sh
    - owner: root
    - group: root
    - mode: 755
    - require:
      - pkg: openvpn
      - pkg: openresolv
