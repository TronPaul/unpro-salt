masquerade:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - jump: MASQUERADE
    - out-interface: eth0
    - save: True

mumble-tcp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - source: '!10.0.0.0/16'
    - proto: tcp
    - dport: 64738
    - to-destination: 10.0.1.5
    - save: True

mumble-udp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - source: '!10.0.0.0/16'
    - proto: udp
    - dport: 64738
    - to-destination: 10.0.1.5
    - save: True

openvpn-udp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - source: '!10.0.0.0/16'
    - proto: udp
    - dport: 1194
    - to-destination: 10.0.1.6
    - save: True

irc-tcp:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: DNAT
    - source: '!10.0.0.0/16'
    - proto: tcp
    - dport: 6667
    - to-destination: 10.0.1.7
    - save: True

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

net.ipv4.conf.eth0.send_redirects:
  sysctl.present:
    - value: 0
