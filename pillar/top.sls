base:
  '*':
    - users
  'not G@domain:ec2.internal':
    - sensu
  'domain:ec2.internal':
    - match: grain
    - ec2
  'roles:rabbitmq':
    - match: grain
    - rabbitmq
  'roles:voice_server':
    - match: grain
    - mumble
  'roles:vpn_server':
    - match: grain
    - vpn-server
  'roles:vpn_client':
    - match: grain
    - openvpn-client
  'nasus':
    - nasus_samba
    - nfs
  'fednet':
    - nfs
