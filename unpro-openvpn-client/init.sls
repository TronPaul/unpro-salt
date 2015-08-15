{% set id = grains['id'] %}
{% set bucket = salt['pillar.get']('unpro-openvpn-client:bucket') %}

include:
  - openvpn-client

extend:
  /etc/openvpn/ca.crt:
    file.managed:
      - source: s3://{{bucket}}/vpn/ca.crt
      - source_hash: s3://{{bucket}}/vpn/ca.crt.sha256
  /etc/openvpn/{{id}}.crt:
    file.managed:
      - source: s3://{{bucket}}/vpn/{{id}}/{{id}}.crt
      - source_hash: s3://{{bucket}}/vpn/{{id}}/{{id}}.crt.sha256
  /etc/openvpn/{{id}}.key:
    file.managed:
      - source: s3://{{bucket}}/vpn/{{id}}/{{id}}.key
      - source_hash: s3://{{bucket}}/vpn/{{id}}/{{id}}.key.sha256

openresolv:
  pkg:
    - installed

/etc/openvpn/update-resolv-conf.sh:
  file.managed:
    - source: salt://unpro-openvpn-client/update-resolv-conf.sh
    - owner: root
    - group: root
    - mode: 755
    - require:
      - pkg: openvpn
      - pkg: openresolv
