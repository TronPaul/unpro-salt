include:
  - docker
  - uwsgi

/usr/share/virtualenvs/dockman:
  virtualenv.manage:
    - python: /usr/bin/python3.4

dockman:
  user.present:
    - groups:
      - docker
      - www-data
    - require:
      - group: docker
      - pkg: nginx
  file.managed:
    - name: /usr/share/dockman/dockman.py
    - source: https://raw.githubusercontent.com/TronPaul/dockman/master/dockman.py
    - source_hash: md5=aa0d7ce78bc968a25e78f301088359ae

/usr/share/dockman/config.json:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - replace: False
    - makedirs: True
    - dir_mode: 755

dockman-uwsgi:
  file.managed:
    - name: /etc/uwsgi/apps-available/dockman.ini
    - source: salt://dockman/dockman.ini
    - template: jinja
    - user: root
    - group: root
    - mode: 644

dockman-nginx:
  file.managed:
    - name: /etc/nginx/sites-available/dockman.conf
    - source: salt://dockman/dockman.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      service: nginx

dockman-uwsgi-enabled:
  file.symlink:
    - name: /etc/uwsgi/apps-enabled/dockman.ini
    - target: /etc/uwsgi/apps-available/dockman.ini
    - require:
      - file: dockman-uwsgi

dockman-nginx-enabled:
  file.symlink:
    - name: /etc/nginx/sites-enabled/dockman.conf
    - target: /etc/nginx/sites-available/dockman.conf
    - require:
      - file: dockman-nginx
    - watch_in:
      - service: nginx
