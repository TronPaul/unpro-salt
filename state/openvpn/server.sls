{% set fqdn = grains['fqdn'] %}
include:
  - .common

/etc/openvpn/server.conf:
  file.managed:
    - source: salt://openvpn/server.conf.jinja
    - template: jinja
    - require:
      - pkg: openvpn
    - watch_in:
      - service: openvpn

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
    - require_in:
      - service: openvpn

{% if 'ec2' in grains %}
{% set bucket = "teamunpro" %}
{% set path = "/ca" %}
{% set base_s3_url = "s3://" + bucket + path %}
key_files:
  file.managed:
    - names:
      - /etc/openvpn/{{fqdn}}.key
        - source: {{base_s3_url}}/{{fqdn}}.key
        - source_hash: {{base_s3_url}}/{{fqdn}}.key.sha256
      - /etc/openvpn/{{fqdn}}.crt
        - source: {{base_s3_url}}/{{fqdn}}.crt
        - source_hash: {{base_s3_url}}/{{fqdn}}.crt.sha256
      - /etc/openvpn/ca.crt
        - source: {{base_s3_url}}/ca.crt
        - source_hash: {{base_s3_url}}/ca.crt.sha256
      - /etc/openvpn/dh2048.pem
        - source: {{base_s3_url}}/dh2048.pem
        - source_hash: {{base_s3_url}}/dh2048.pem.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn
    - require_in:
      - service: openvpn
{% else %}
key_files:
  file.exists:
    - names:
      - /etc/openvpn/{{fqdn}}.key
      - /etc/openvpn/{{fqdn}}.crt
      - /etc/openvpn/ca.crt
      - /etc/openvpn/dh2048.pem
    - require_in:
      - service: openvpn
{% endif %}
