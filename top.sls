base:
  '*':
    - sensu
    - ntp
    - unpro-sensu.client
  'roles:rabbitmq':
    - match: grain
    - rabbitmq
    - rabbitmq.config
  'roles:monitor_master':
    - match: grain
    - unpro-sensu.server
    - sensu.api
    - sensu.uchiwa
  'roles:irc_bot':
    - match: grain
    - lazybot
  'roles:irc_bouncer':
    - match: grain
    - znc
  'roles:vpn_server':
    - match: grain
    - unpro-openvpn
    - bind
    - bind.config
  'roles:aws_nat':
    - match: grain
    - aws.nat
  'roles:voice_server':
    - match: grain
    - mumble_servers
  'roles:sshserver':
    - match: grain
    - openssh
    - openssh.config
  'roles:torrentserver':
    - match: grain
    - unpro-deluge
  'roles:nas':
    - match: grain
    - samba
    - unpro-nfs.server
  'roles:htpc':
    - match: grain
    - xbmc
    - pcsx2
    - desmume
    - dolphin
  'roles:nas_client':
    - match: grain
    - nfs.client
  'roles:vpn_client':
    - match: grain
    - unpro-openvpn-client
  'G@roles:monitor_master and G@virtual:VirtualBox':
    - match: compound
    - redis.server
  'G@roles:voice_server and G@ec2:instance_id':
    - match: compound
    - mumble_servers.database
  'G@roles:vpn_server and G@ec2:instance_id':
    - match: grain
    - unpro-openvpn.files
