openvpn:
  server:
    fqdn: vpn.teamunpro.com
    network: 10.0.254.0
    netmask: 255.255.255.0
    ip_addr: 10.0.254.1
    routes:
      {%- if salt['grains.get']('virtual') == 'VirtualBox' %}
      - network: 192.168.50.0
        netmask: 255.255.255.0
      {%- elif salt['grains.get']('ec2') == None %}
      - network: 10.0.1.0
        netmask: 255.255.255.0
      {%- endif %}
