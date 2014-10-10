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

net.ipv4.conf.all.send_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.default.send_redirects:
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

{% for iface in salt['grains.get']('ip_interfaces', {}).keys() %}
net.ipv4.conf.{{ iface }}.rp_filter:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.{{ iface }}.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv4.conf.{{ iface }}.send_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec

net.ipv6.conf.{{ iface }}.accept_redirects:
  sysctl.present:
    - value: 0
    - require_in:
      - service: ipsec
{% endfor %}

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
