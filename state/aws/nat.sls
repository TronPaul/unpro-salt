masquerade:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - jump: MASQUERADE
    - out-interface: eth0
    - source: ip-10-0-0-0.ec2.internal/16
    - save: True

mumble-tcp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - source: !ip-10-0-0-0.ec2.internal/16
    - proto: tcp
    - dport: 64738
    - to-destination: ip-10-0-1-10.ec2.internal
    - save: True

mumble-udp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - source: !ip-10-0-0-0.ec2.internal/16
    - proto: udp
    - dport: 64738
    - to-destination: ip-10-0-1-10.ec2.internal
    - save: True

openvpn-udp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - source: !ip-10-0-0-0.ec2.internal/16
    - proto: udp
    - dport: 1194
    - to-destination: ip-10-0-1-11.ec2.internal
    - save: True

https-tcp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - source: !ip-10-0-0-0.ec2.internal/16
    - proto: tcp
    - dport: 443
    - to-destination: ip-10-0-1-12.ec2.internal
    - save: True

http-tcp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - source: !ip-10-0-0-0.ec2.internal/16
    - proto: tcp
    - dport: 80
    - to-destination: ip-10-0-1-12.ec2.internal
    - save: True

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

net.ipv4.conf.eth0.send_redirects:
  sysctl.present:
    - value: 0
