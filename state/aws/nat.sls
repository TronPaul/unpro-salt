masquerade:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - jump: MASQUERADE
    - out-interface: eth0
    - source: 10.0.0.0/16
    - save: True

mumble-tcp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - in-interface: eth0
    - proto: tcp
    - dport: 64738
    - destination: 
    - to-destination: 10.0.1.10
    - save: True

mumble-udp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - in-interface: eth0
    - proto: udp
    - dport: 64738
    - to-destination: 10.0.1.10
    - save: True

openvpn-udp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - in-interface: eth0
    - proto: udp
    - dport: 1194
    - to-destination: 10.0.1.11
    - save: True

https-tcp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - in-interface: eth0
    - proto: tcp
    - dport: 443
    - to-destination: 10.0.1.12
    - save: True

http-tcp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - in-interface: eth0
    - proto: tcp
    - dport: 80
    - to-destination: 10.0.1.12
    - save: True

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

net.ipv4.conf.eth0.send_redirects:
  sysctl.present:
    - value 0
