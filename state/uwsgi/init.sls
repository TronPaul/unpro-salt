include:
  - dev.python

uwsgi:
  service.running:
    - require:
      - file: /etc/init/uwsgi.conf
      - pip: uwsgi
  pip.installed:
    - require:
      - pkg: python-pip

/etc/init/uwsgi.conf:
  file.managed:
    - source: salt://uwsgi/uwsgi.conf
    - template: jinja

/etc/uwsgi:
  file.directory

/etc/uwsgi/uwsgi.ini:
  file.managed:
    - source: salt://uwsgi/uwsgi.ini
    - require:
      - file: /etc/uwsgi

/etc/uwsgi/apps-available:
  file.directory:
    - user: root
    - group: root
    - require:
      - file: /etc/uwsgi

/etc/uwsgi/apps-enabled:
  file.directory:
    - user: root
    - group: root
    - require:
      - file: /etc/uwsgi

/var/log/uwsgi:
  file.directory:
    - user: www-data
    - group: www-data
    - require:
      - pkg: nginx

/var/log/uwsgi/app:
  file.directory:
    - user: www-data
    - group: www-data
    - require:
      - file: /var/log/uwsgi

/var/log/uwsgi/emporer.log:
  file.touch:
    - user: www-data
    - group: www-data
    - require:
      - file: /var/log/uwsgi

