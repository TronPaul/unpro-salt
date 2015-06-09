include:
  - sensu.server

extend:
  /etc/sensu/handlers:
    file.recurse:
      - source: salt://unpro-sensu/handlers
      - file_mode: 555
      - require:
        - pkg: sensu
      - require_in:
        - service: sensu-server
      - watch_in:
        - service: sensu-server
  /etc/sensu/conf.d:
    file.recurse:
      - source: salt://unpro-sensu/conf.d
      - template: jinja
      - require:
        - pkg: sensu
      - require_in:
        - service: sensu-server
