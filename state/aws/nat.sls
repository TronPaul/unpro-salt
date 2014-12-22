masquerade:
  iptables.append:
    table: nat
    chain: POSTROUTING
    jump: MASQUERADE
    out-interface: eth0
    source: 10.0.0.0/16
    save: True

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
