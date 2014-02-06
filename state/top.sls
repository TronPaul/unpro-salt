file_roots:
  base:
    - /srv/salt

base:
  '*':
    - edit.vim
    - unpro-salt
  'teamunpro.com*':
    - users
    - nginx
    - blog_teamunpro_com
    - mumble-servers
    - dev.python
    - openssh
    - openssh.config
