openvpn:
  server:
    vpn.teamunpro.com:
      remote: teamunpro.ddns.net
      float: True
      ifconfig: 10.99.99.2 10.99.99.1
      secret: secret
      route: 192.168.1.0 255.255.255.0
      ping: 15
      ping_restart: 20
      persist_local_ip: True
      persist_remote_ip: True
  lookup:
    dh_files: []

bind:
  lookup:
    pkgs: 
      - bind9
      - bind9utils
  configured_views:
    internal:
      match_clients:
        - 10.0.0.0/8
      allow-query:
        - 10.0.0.0/8
      recursion: yes
      configured_zones:
        teamunpro:
          type: forward
          forwarders: "10.0.0.2;"
        ec2.internal:
          type: forward
          forwarders: "10.0.0.2;"
