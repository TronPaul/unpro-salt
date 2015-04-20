base:
  '*':
    - users
  'domain:ec2.internal':
    - match: grain
    - ec2
  'roles:vpn_client':
    - match: grain
    - openvpn_client
  'roles:vpn_server':
    - match: grain
    - openvpn_server
  'roles:voice_server':
    - match: grain
    - mumble_servers
  'roles:rabbitmq':
    - match: grain
    - rabbitmq
  'nasus':
    - nasus_samba
    - nasus_nfs
  'fednet':
    - fednet_nfs_client
