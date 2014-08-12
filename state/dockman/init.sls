include:
  - docker
  - uwsgi

/usr/share/virtualenvs/dockman:
  virtualenv.manage:
    - python: /usr/bin/python2.7

dockman:
  user.present:
    - groups:
      - docker
      - www-data
    - require:
      - group: docker
      - pkg: nginx
    - require_in:
      - service: uwsgi
  pip.installed:
    - name: dockman == 0.4.1
    - bin_env: /usr/share/virtualenvs/dockman
    - require:
      - virtualenv: /usr/share/virtualenvs/dockman
    - require_in:
      - service: uwsgi

/usr/share/dockman/config.json:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - replace: False
    - makedirs: True
    - dir_mode: 755
    - contents: {}
    - require_in:
      - service: uwsgi

/usr/share/dockman/dockman.ini:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://dockman/dockman.ini.flask
    - makedirs: True
    - dir_mode: 755
    - require_in:
      - service: uwsgi

dockman-uwsgi:
  file.managed:
    - name: /etc/uwsgi/apps-available/dockman.ini
    - source: salt://dockman/dockman.ini.uwsgi
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require_in:
      - service: uwsgi
    - require:
      - file: /etc/uwsgi/apps-available

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
    - require_in:
      - service: nginx

dockman-uwsgi-enabled:
  file.symlink:
    - name: /etc/uwsgi/apps-enabled/dockman.ini
    - target: /etc/uwsgi/apps-available/dockman.ini
    - require:
      - file: dockman-uwsgi
      - file: /etc/uwsgi/apps-enabled
    - require_in:
      - service: uwsgi

dockman-nginx-enabled:
  file.symlink:
    - name: /etc/nginx/sites-enabled/dockman.conf
    - target: /etc/nginx/sites-available/dockman.conf
    - require:
      - file: dockman-nginx
    - watch_in:
      - service: nginx
    - require_in:
      - service: nginx
