openvpn:
  server:
    server: 10.1.0.0 255.255.255.0
    ca: ca.crt
    cert: vpn.teamunpro.com.crt
    key: vpn.teamunpro.com.key
    dh: dh2048.pem
    push:
      - route 10.0.0.0 255.255.255.0
      - route 10.0.1.0 255.255.255.0
      - dhcp-option DNS 10.1.0.1
    ifconfig-pool-persist: ipp.txt
    client_to_client: True
    keepalive: '10 120'
    status: openvpn-status.log
  lookup:
    dh_files: []
