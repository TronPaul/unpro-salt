include:
  - nginx

extend:
  nginx:
    file.symlink:
      - name: /etc/nginx/sites-enabled/deluge.nasus.conf
      - target: /etc/nginx/sites-available/deluge.nasus.conf
      - require:
        - file: /etc/nginx/sites-available/deluge.nasus.conf
    service:
      - watch:
        - file: /etc/nginx/sites-enabled/deluge.nasus.conf
        - file: /etc/nginx/sites-available/deluge.nasus.conf

/etc/nginx/sites-available/deluge.nasus.conf:
  file.managed:
    - source: salt://deluge/deluge.nasus.conf
