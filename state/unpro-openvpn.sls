{% set id = grains['id'] %}
{% set bucket = salt['pillar.get']('secrets:bucket') %}
{% set servers = salt['pillar.get']('openvpn:server', {}).values() %}
include:
  - openvpn

{% for server in servers %}
{% if bucket %}
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

{% set ccd = server.get('client_config_dir') %}
{% if ccd %}
/etc/openvpn/{{ccd}}:
  file.directory:
    - user: root
    - group: root
    - require_in:
      - service: openvpn

{% for name, contents in server.get('clients', {}).items() %}
/etc/openvpn/{{ccd}}/{{name}}:
  file.managed:
    - user: root
    - group: root
    - contents: {{contents}}
    - require_in:
      - service: openvpn
    - require:
      file: /etc/openvpn/{{ccd}}
{% endfor %}
{% endif %}
{% endif %}
{% endfor %}

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
    - require_in:
      - service: openvpn

vpn-connections:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: tun+
    - jump: ACCEPT
    - destination: 10.0.0.0/16

vpn-forwarding:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - in-interface: tun+
    - jump: ACCEPT
    - destination: 10.0.0.0/16

eth0-forwarding:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - out-interface: tun+
    - jump: ACCEPT
    - source: 10.0.0.0/16
    - destination: 10.1.0.0/24
