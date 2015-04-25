openvpn:
  server:
    vpn.teamunpro.com:
      server: 10.1.0.0 255.255.255.0
      ca: ca.crt
      cert: vpn.teamunpro.com.crt
      key: vpn.teamunpro.com.key
      dh: dh2048.pem
      push:
        - route 10.0.0.0 255.255.255.0
        - route 10.0.1.0 255.255.255.0
        - route 192.168.1.0 255.255.255.0
      ifconfig-pool-persist: ipp.txt
      client_to_client: True
      keepalive: '10 120'
      status: openvpn-status.log
      client_config_dir: ccd
      clients:
        sjds-laptop: iroute 192.168.1.0 255.255.255.0
  lookup:
    dh_files: []
bind:
  lookup:
    pkgs: ["bind9", "bind9utils"]
  configured_views:
    internal:
      match_clients:
        - 10.0.0.0/8
      configured_zones:
        teamunpro:
          type: forward
          forwarders: "10.0.0.2;"
