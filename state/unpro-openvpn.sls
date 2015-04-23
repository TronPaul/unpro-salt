{% set id = grains['id'] %}
{% set bucket = salt['pillar.get']('secrets:bucket') %}
{% set servers = salt['pillar.get']('openvpn:server', {}).values() %}
include:
  - openvpn

{% if bucket %}
{% for server in servers %}
/etc/openvpn/{{server['ca']}}:
  file.managed:
    - source: s3://{{bucket}}/vpn_ca/{{server['ca']}}
    - source_hash: s3://{{bucket}}/vpn_ca/{{server['ca']}}.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn

/etc/openvpn/{{server['cert']}}:
  file.managed:
    - source: s3://{{bucket}}/vpn_ca/{{server['cert']}}
    - source_hash: s3://{{bucket}}/vpn_ca/{{server['cert']}}.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn

/etc/openvpn/{{server['key']}}:
  file.managed:
    - source: s3://{{bucket}}/vpn_ca/{{server['key']}}
    - source_hash: s3://{{bucket}}/vpn_ca/{{server['key']}}.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn

/etc/openvpn/{{server['dh']}}:
  file.managed:
    - source: s3://{{bucket}}/vpn_ca/{{server['dh']}}dh2048.pem
    - source_hash: s3://{{bucket}}/vpn_ca/{{server['dh']}}.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn
{% endfor %}
{% endif %}

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
    - require_in:
      - service: openvpn
