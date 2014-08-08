include:
  - docker

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
  service:
    - running
    - watch:
      - file: /etc/dockman/config.json
