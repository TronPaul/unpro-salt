file_roots:
  base:
    - /srv/salt

base:
  '*':
    - edit.vim
  '* and not G@virtual:VirtualBox':
    - match: compound
    - unpro-salt
  'roles:webserver':
    - match: grain
    - nginx
  'roles:voiceserver':
    - match: grain
    - mumble-servers
  'roles:pythondev':
    - match: grain
    - dev.python
  'roles:sshserver':
    - match: grain
    - openssh
    - openssh.config
  'roles:torrentserver':
    - match: grain
    - deluge.deluged
    - deluge.deluge-web
    - deluge.proxy
  'roles:windowsfileserver':
    - match: grain
    - samba
  'teamunpro.com*':
    - users
    - blog_teamunpro_com
