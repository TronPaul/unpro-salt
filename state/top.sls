file_roots:
  base:
    - /srv/salt

base:
  '*':
    - edit.vim
  'teamunpro.com*':
    - users
    - nginx
    - blog_teamunpro_com
    - mumble-servers
