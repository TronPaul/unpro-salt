include:
  - openvpn

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
    - require_in:
      - service: openvpn

vpn-aws-connections:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: tun+
    - jump: ACCEPT
    - destination: 10.0.0.0/16

vpn-chi-connections:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: tun+
    - jump: ACCEPT
    - destination: 172.20.254.0/24

vpn-aws-forwarding:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - in-interface: tun+
    - jump: ACCEPT
    - destination: 10.0.0.0/16

eth0-chi-forwarding:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - out-interface: tun+
    - jump: ACCEPT
    - source: 10.0.0.0/16
    - destination: 172.20.254.0/24

vpn-chi-forwarding:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - out-interface: tun+
    - jump: ACCEPT
    - source: 10.1.0.0/24
    - destination: 172.20.254.0/24
