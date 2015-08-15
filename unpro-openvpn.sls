include:
  - openvpn

{% for name, config in salt['pillar.get']('openvpn:server', {}).iteritems() %}
{% for file in ('secret', 'ca', 'cert', 'key') %}
{% if file in config %}
/etc/openvpn/{{config[file]}}:
  file.managed:
    - source: salt://openvpn/{{name}}/{{config[file]}}
    - require_in:
      - service: openvpn
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
    - destination: 192.168.1.0/24
