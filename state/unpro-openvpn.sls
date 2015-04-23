{% set id = grains['id'] %}
{% set bucket = salt['pillar.get']('secrets:bucket') %}
{% set openvpn = salt['pillar.get']('openvpn:server') %}
include:
  - openvpn

{% if bucket %}
/etc/openvpn/{{openvpn['ca']}}:
  file.managed:
    - source: s3://{{bucket}}/vpn_ca/{{openvpn['ca']}}
    - source_hash: s3://{{bucket}}/vpn_ca/{{openvpn['ca']}}.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn

/etc/openvpn/{{openvpn['cert']}}:
  file.managed:
    - source: s3://{{bucket}}/vpn_ca/{{openvpn['cert']}}
    - source_hash: s3://{{bucket}}/vpn_ca/{{openvpn['cert']}}.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn

/etc/openvpn/{{openvpn['key']}}:
  file.managed:
    - source: s3://{{bucket}}/vpn_ca/{{openvpn['key']}}
    - source_hash: s3://{{bucket}}/vpn_ca/{{openvpn['key']}}.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn

/etc/openvpn/{{openvpn['dh']}}:
  file.managed:
    - source: s3://{{bucket}}/vpn_ca/{{openvpn['dh']}}dh2048.pem
    - source_hash: s3://{{bucket}}/vpn_ca/{{openvpn['dh']}}.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn
{% endif %}

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
    - require_in:
      - service: openvpn
