nginx:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: nginx
    - watch:
      - pkg: nginx

/etc/nginx/sites-enabled/default:
  file.absent:
    - require_in:
      - service: nginx

/srv/http:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - require_in:
      - service: nginx
