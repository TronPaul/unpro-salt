file_roots:
  base:
    - /srv/salt

base:
  '*':
    - edit.vim
  '* and not G@virtual:VirtualBox':
    - match: compound
    - unpro-salt
  'teamunpro.com*':
    - users
    - nginx
    - blog_teamunpro_com
    - mumble-servers
    - dev.python
    - openssh
    - openssh.config
