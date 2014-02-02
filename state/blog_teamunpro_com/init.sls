include:
  - nginx

extend:
  nginx:
    file.symlink:
      - name: /etc/nginx/sites-enabled/blog.teamunpro.com.conf
      - target: /etc/nginx/sites-available/blog.teamunpro.com.conf
      - require:
        - file: /etc/nginx/sites-available/blog.teamunpro.com.conf
    service:
      - watch:
        - file: /etc/nginx/sites-enabled/blog.teamunpro.com.conf
        - file: /etc/nginx/sites-available/blog.teamunpro.com.conf

/etc/nginx/sites-available/blog.teamunpro.com.conf:
  file.managed:
    - source: salt://blog_teamunpro_com/blog.teamunpro.com.conf

/srv/http/blog.teamunpro.com/html:
  file.directory:
    - user: pelican
    - group: www-data
    - mode: 755
    - makedirs: True
    - require:
      - user: pelican

pelican:
  user.present:
    - shell: /bin/sh
    - groups:
      - www-data
    - require:
      - pkg: nginx

tron_linode:
  ssh_auth.present:
    - source: salt://ssh_keys/tron_linode.id_rsa.pub
    - user: pelican

tron_laptop:
  ssh_auth.present:
    - source: salt://ssh_keys/tron_laptop.id_rsa.pub
    - user: pelican
