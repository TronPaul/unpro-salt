/usr/local/bin/salt-up:
  file.managed:
    - source: salt://unpro-salt/salt-up
    - user: root
    - group: root
    - mode: 755
  cron.present:
    - user: root
    - minute: random
    - hour: 20
    - comment: 'Update salt data from git'
    - require:
      - file: /usr/local/bin/salt-up
