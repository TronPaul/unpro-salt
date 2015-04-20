masquerade:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - jump: MASQUERADE
    - out-interface: eth0
    - source: 10.0.1.0/24
    - destination: '!10.0.1.0/24'
    - save: True

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

net.ipv4.conf.eth0.send_redirects:
  sysctl.present:
    - value: 0
