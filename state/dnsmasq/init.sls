dnsmasq:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: dnsmasq
    - watch:
      - file: /etc/dnsmasq.conf

/etc/dnsmasq.conf:
  file.managed:
    - source: salt://dnsmasq/dnsmasq.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: dnsmasq

vpn_fix:
  cmd.run:
    - name: sed -i '/^exit 0$/ i\/etc/init.d/dnsmasq restart' /etc/rc.local
    - unless: grep -q '^/etc/init.d/dnsmasq restart$' /etc/rc.local
    - require:
      - pkg: dnsmasq
