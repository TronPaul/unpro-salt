{% set id = grains['id'] %}

include:
  - openvpn-client

extend:
  openvpn-client:
    /etc/openvpn/ca.crt:
      file.managed:
        source: s3://{{bucket}}/vpn_ca/ca.crt
    /etc/openvpn/{{id}}.crt:
      file.managed:
        source: s3://{{bucket}}/vpn_ca/{{id}}.crt
    /etc/openvpn/{{id}}.key:
      file.managed:
        source: s3://{{bucket}}/vpn_ca/{{id}}.key

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
