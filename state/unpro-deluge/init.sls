include:
  - nginx
  - deluge.deluged
  - deluge.deluge-web

extend:
  nginx:
    file.symlink:
      - name: /etc/nginx/sites-enabled/deluge
      - target: /etc/nginx/sites-available/deluge
      - require:
        - file: /etc/nginx/sites-available/deluge
    service:
      - watch:
        - file: /etc/nginx/sites-enabled/deluge
        - file: /etc/nginx/sites-available/deluge

/etc/nginx/sites-available/deluge:
  file.managed:
    - source: salt://unpro-deluge/deluge
