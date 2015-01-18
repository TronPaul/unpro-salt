{% set fqdn = salt['pillar.get']('openvpn:server:fqdn', grains['fqdn']) %}
include:
  - .common

dnsmasq:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: dnsmasq
      - service: openvpn
    - watch:
      - file: /etc/dnsmasq.conf

/etc/dnsmasq.conf:
  file.managed:
    - template: jinja
    - source: salt://openvpn/dnsmasq.conf.jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: dnsmasq

vpn_fix:
  cmd.run:
    - name: sed -i '/^exit 0$/ i\/etc/init.d/dnsmasq restart' /etc/rc.local
    - unless: grep -q '^/etc/init.d/dnsmasq restart$' /etc/rc.local
    - require:
      - pkg: dnsmasq

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
/etc/openvpn/{{fqdn}}.key:
  file.managed:
    - source: s3://teamunpro/vpn_ca/{{fqdn}}.key
    - source_hash: s3://teamunpro/vpn_ca/{{fqdn}}.key.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn
    - require_in:
      - service: openvpn
    
/etc/openvpn/{{fqdn}}.crt:
  file.managed:
    - source: s3://teamunpro/vpn_ca/{{fqdn}}.crt
    - source_hash: s3://teamunpro/vpn_ca/{{fqdn}}.crt.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn
    - require_in:
      - service: openvpn

/etc/openvpn/ca.crt:
  file.managed:
    - source: s3://teamunpro/vpn_ca/ca.crt
    - source_hash: s3://teamunpro/vpn_ca/ca.crt.sha256
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn
    - require_in:
      - service: openvpn

/etc/openvpn/dh2048.pem:
  file.managed:
    - source: s3://teamunpro/vpn_ca/dh2048.pem
    - source_hash: s3://teamunpro/vpn_ca/dh2048.pem.sha256
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
