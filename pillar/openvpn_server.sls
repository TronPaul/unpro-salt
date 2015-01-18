openvpn:
  server:
    fqdn: vpn.teamunpro.com
    routes:
      {% if salt['grains.get']('virtual') == 'VirtualBox' %}
      - network: 192.168.50.0
        netmask: 255.255.255.0
      {% endif %}
