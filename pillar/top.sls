base:
  '*':
    - users
  'domain:ec2.internal':
    - match: grain
    - ec2
  'roles:rabbitmq':
    - match: grain
    - rabbitmq
  'roles:monitor_master':
    - match: grain
    - sensu
  'roles:voice_server':
    - match: grain
    - mumble_servers
  'roles:vpn_server':
    - match: grain
    - openvpn_server
  'roles:vpn_client':
    - match: grain
    - openvpn_client
  'nasus':
    - nasus_samba
    - nasus_nfs
  'fednet':
    - fednet_nfs_client
