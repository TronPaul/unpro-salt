include:
  - nginx

nginx-enabled:
  file.symlink:
    - name: /etc/nginx/sites-enabled/blog.teamunpro.com.conf
    - target: /etc/nginx/sites-available/blog.teamunpro.com.conf
    - require:
      - file: /etc/nginx/sites-available/blog.teamunpro.com.conf
    - watch_in:
      - service: nginx

/etc/nginx/sites-available/blog.teamunpro.com.conf:
  file.managed:
    - source: salt://blog_teamunpro_com/blog.teamunpro.com.conf
    - watch_in:
      - service: nginx

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

# Add key for pelican
#pelican_key:
#  ssh_auth.present:
#    - source: salt://blog_teamunpro_com/pelican.pub
#    - user: pelican
#    - require:
#       - user: pelican
