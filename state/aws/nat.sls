masquerade:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - jump: MASQUERADE
    - out-interface: eth0
    - source: 10.0.0.0/16
    - save: True

mumble:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - proto: tcp
    - dport: 64738
    - to-destination: 10.0.1.10
    - save: True

mumble:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - proto: udp
    - dport: 64738
    - to-destination: 10.0.1.10
    - save: True

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
