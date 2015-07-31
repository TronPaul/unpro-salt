base:
  '*':
    - sensu
    - ntp
    - unpro-sensu.client
  '* and not G@virtual:VirtualBox':
    - match: compound
    - unpro_salt
  'roles:rabbitmq':
    - match: grain
    - rabbitmq
    - rabbitmq.config
  'G@roles:monitor_master and G@virtual:VirtualBox':
    - match: compound
    - redis.server
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
    - deluge.deluged
    - deluge.deluge-web
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
