include:
  - sensu.client

extend:
  /etc/sensu/plugins:
    file.recurse:
      - source: salt://unpro-sensu/plugins
      - file_mode: 555
      - require:
        - pkg: sensu
      - require_in:
      - service: sensu-client
      - watch_in:
        - service: sensu-client
  /etc/sensu/conf.d/client.json:
    file.managed:
      - source: salt://unpro-sensu/client.json
      - template: jinja
      - user: root
      - group: root
      - mode: 644
      - require:
        - pkg: sensu
