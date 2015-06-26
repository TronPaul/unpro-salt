include:
  - sensu.server

extend:
  /etc/sensu/conf.d:
    file.recurse:
      - source: salt://unpro-sensu/conf.d
      - template: jinja
      - require:
        - pkg: sensu
      - require_in:
        - service: sensu-server
