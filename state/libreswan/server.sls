include:
  - .common

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
    - require_in:
      - service: ipsec

net.ipv4.conf.default.rp_filter:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.all.rp_filter:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.default.accept_source_route:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv6.conf.default.accept_source_route:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.all.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv6.conf.all.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.default.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv6.conf.default.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

