include:
  - .init

{% for name, mumble_server in pillar.get('mumble_servers', {}).items() %}
/var/lib/mumble/{{name}}.sqlite:
  file.managed:
    - user: mumble-server
    - group: mumble-server
    - mode: 600
    - replace: False
    - source: salt://mumble/{{name}}.sqlite
    - watch_in:
      - service: mumble-server_{{name}}
    - require_in:
      - service: mumble-server_{{name}}
{% endfor %}
