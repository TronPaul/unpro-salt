include:
  - .common
  - nginx
  - docker

uwsgi:
    pip.installed:
        - require:
            - pkg: python-dev
            - pkg: python-pip

/etc/init/uwsgi:
  file.managed:
    - source: salt://dockman/dockman.conf

/etc/dockman/config.json:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - replace: False
    - makedirs: True
    - dir_mode: 755

dockman:
  pip.installed:
    - require:
      - pkg: python-pip
