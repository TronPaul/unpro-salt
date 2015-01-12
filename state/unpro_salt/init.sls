/usr/local/bin/salt-up:
  file.managed:
    - source: salt://unpro_salt/salt-up
    - user: root
    - group: root
    - mode: 755
  cron.present:
    - user: root
    - minute: random
    - hour: 20
    - identifier: unpro_salt_update
    - comment: 'Update salt data from git'
    - require:
      - file: /usr/local/bin/salt-up
